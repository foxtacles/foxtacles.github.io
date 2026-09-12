on PlaySound SoundFile, Important
  AvChan = 0
  repeat with i = 1 to 4
    if soundBusy(i) = 0 then
      AvChan = i
      exit repeat
    end if
  end repeat
  if (AvChan = 0) and (Important = 1) then
    AvChan = random(4)
  end if
  if AvChan > 0 then
    puppetSound(AvChan, SoundFile)
  end if
end
