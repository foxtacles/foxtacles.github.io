#!/usr/bin/env python3
"""Serve the local DirPlayer smoke test without uploading game data."""
from http.server import ThreadingHTTPServer, SimpleHTTPRequestHandler
from pathlib import Path
from urllib.parse import urlsplit, unquote, parse_qs
BASE=Path(__file__).resolve().parents[2]
ROOTS={'patched':BASE/'tools/runtime-options/dirplayer-rs/dist-polyfill','disc':BASE/'artifacts/disc','runtime':BASE/'tools/runtime-options/dirplayer-polyfill-0.8.1'}
class Handler(SimpleHTTPRequestHandler):
    def translate_path(self,path):
        parts=unquote(urlsplit(path).path).strip('/').split('/')
        root=ROOTS.get(parts[0],Path(__file__).parent)
        rel=parts[1:] if parts[0] in ROOTS else parts
        cur=root
        for part in rel:
            if part in ('','.'):
                continue
            if part=='..':return str(root/'__invalid__')
            choices={p.name.casefold():p for p in cur.iterdir()} if cur.is_dir() else {}
            cur=choices.get(part.casefold(),cur/part)
        if not cur.exists() and cur.suffix.lower() in ('.cct','.dcr'):
            fallback=cur.with_suffix('.CXT' if cur.suffix.lower()=='.cct' else '.DXR')
            if fallback.exists():cur=fallback
        return str(cur)
    def do_POST(self):
        parsed=urlsplit(self.path)
        length=int(self.headers.get('Content-Length','0'))
        if parsed.path!='/capture' or not 0 < length <= 10000000:
            self.send_error(400);return
        data=self.rfile.read(length)
        if not data.startswith(b'\x89PNG\r\n\x1a\n'):
            self.send_error(400);return
        query=parse_qs(parsed.query)
        movie=query.get('movie',['scene'])[0]
        label=query.get('runtime',['release'])[0]
        if not movie.isalnum() or label not in ('release','patched'):
            self.send_error(400);return
        dest=BASE/'artifacts/runtime-tests'/f'browser-{movie}-{label}.png'
        dest.write_bytes(data)
        self.send_response(200);self.end_headers();self.wfile.write(str(dest).encode())
    def end_headers(self):
        self.send_header('Cache-Control','no-store')
        super().end_headers()
if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--port', type=int, default=8766)
    args = parser.parse_args()
    ThreadingHTTPServer(('127.0.0.1', args.port), Handler).serve_forever()
