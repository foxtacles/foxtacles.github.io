//! Decode and validate every extracted D7 sndH/sndS pair, without Web Audio.
use binary_reader::{BinaryReader, Endian};
use std::{env, fs, path::PathBuf};
use vm_rust::director::chunks::sound::{SndHeaderChunk, SoundChunk};
use vm_rust::player::handlers::datum_handlers::sound_channel::SoundChannel;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let root = PathBuf::from(env::args().nth(1).expect("findus_audio_audit artifacts/decompiled"));
    let mut paths = vec![];
    for entry in fs::read_dir(&root)? {
        let chunks = entry?.path().join("chunks");
        if !chunks.is_dir() { continue; }
        for entry in fs::read_dir(chunks)? {
            let path = entry?.path();
            if path.file_name().unwrap().to_string_lossy().starts_with("sndH-") && path.extension().is_some_and(|e| e == "bin") {
                paths.push(path);
            }
        }
    }
    paths.sort();
    assert!(!paths.is_empty(), "no sndH assets found");
    let mut results = vec![];
    for path in paths {
        let id: u32 = path.file_stem().unwrap().to_str().unwrap().strip_prefix("sndH-").unwrap().parse()?;
        // This disc consistently has adjacent sndH and sndS IDs; assert rather than guess missing data.
        let samples_path = path.with_file_name(format!("sndS-{}.bin", id + 1));
        let header_bytes = fs::read(&path)?;
        let samples = fs::read(&samples_path)?;
        let mut reader = BinaryReader::from_u8(&header_bytes);
        reader.endian = Endian::Big;
        let header = SndHeaderChunk::from_reader(&mut reader)?;
        let sound = SoundChunk::from_snd_header_and_samples(&header, &samples);
        let data = SoundChannel::load_director_audio_data(&sound.data(), sound.channels(),
            sound.sample_rate(), sound.bits_per_sample(), &sound.codec(),
            Some(sound.sample_count()), sound.big_endian_data())?;
        assert!(data.compressed_data.is_none(), "unexpected compression: {}", path.display());
        assert_eq!(data.samples.len(), sound.sample_count() as usize * sound.channels() as usize, "frame count {}", path.display());
        assert_eq!(samples.len(), data.samples.len() * sound.bits_per_sample() as usize / 8, "raw byte count {}", path.display());
        let expected: Vec<f32> = match sound.bits_per_sample() {
            8 => samples.iter().map(|&v| (v as f32 - 128.0) / 128.0).collect(),
            16 => samples.chunks_exact(2).map(|b| i16::from_be_bytes([b[0], b[1]]) as f32 / 32768.0).collect(),
            bits => panic!("unexpected PCM width: {bits}"),
        };
        assert_eq!(data.samples, expected, "sample values {}", path.display());
        let min = data.samples.iter().copied().fold(f32::INFINITY, f32::min);
        let max = data.samples.iter().copied().fold(f32::NEG_INFINITY, f32::max);
        let rms = (data.samples.iter().map(|&v| (v as f64).powi(2)).sum::<f64>() / data.samples.len() as f64).sqrt();
        results.push(serde_json::json!({
            "header": path.strip_prefix(&root)?.to_string_lossy(),
            "samples": samples_path.strip_prefix(&root)?.to_string_lossy(),
            "header_bytes": header_bytes.len(), "raw_bytes": samples.len(),
            "sample_rate": sound.sample_rate(), "bits": sound.bits_per_sample(),
            "channels": sound.channels(), "frames": sound.sample_count(),
            "duration_ms": sound.sample_count() as f64 * 1000.0 / sound.sample_rate() as f64,
            "min": min, "max": max, "rms": rms, "exact_pcm_match": true,
        }));
    }
    println!("{}", serde_json::to_string_pretty(&serde_json::json!({"passed": results.len(), "assets": results}))?);
    Ok(())
}
