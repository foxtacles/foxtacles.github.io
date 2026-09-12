on InitWheelVar
  global StartWheelCast, WheelSpriteNr, AktWheelStep, AntalWheelBilder, WTimer, WheelFrameTid, MaskinAktiv, Stong, StongDirection, UWheelPos, OnPos
  OnPos = [0, 0, 0, 0]
  StartWheelCast = [15, 76, 130, 184]
  AntalWheelBilder = [36, 43, 36, 43]
  WheelSpriteNr = [21, 25, 20, 26]
  AktWheelStep = [0, 0, 0, 0]
  WheelFrameTid = 7
  MaskinAktiv = 0
  Stong = 7
  StongDirection = 1
  UWheelPos = []
  repeat with i = 1 to 4
    add(UWheelPos, the loc of sprite WheelSpriteNr[i])
  end repeat
end
