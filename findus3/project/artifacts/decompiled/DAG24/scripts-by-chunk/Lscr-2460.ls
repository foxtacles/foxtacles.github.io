on SpinWheel Nr
  global StartWheelCast, WheelSpriteNr, AktWheelStep, AntalWheelBilder
  AktWheelStep[Nr] = AktWheelStep[Nr] + 1
  if AktWheelStep[Nr] >= AntalWheelBilder[Nr] then
    AktWheelStep[Nr] = 0
  end if
  CNr = StartWheelCast[Nr] + AktWheelStep[Nr]
  sprite(WheelSpriteNr[Nr]).member = member(CNr, "HjulMaskin")
end
