on CheckWheelLoc WNr
  global WheelSpriteNr, UWheelPos, OnPos
  tx = the locH of sprite WheelSpriteNr[WNr]
  ty = the locV of sprite WheelSpriteNr[WNr]
  t = 20
  if (WNr = 3) or (WNr = 1) then
    Ok = 0
    if (tx > (343 - t)) and (tx < (343 + t)) and (ty > (245 - t)) and (ty < (245 + t)) then
      Ok = 1
    end if
    if (WNr = 1) and (OnPos[3] = 0) then
      Ok = 0
    end if
    if Ok = 0 then
      set the loc of sprite WheelSpriteNr[WNr] to UWheelPos[WNr]
    end if
    if Ok = 1 then
      set the loc of sprite WheelSpriteNr[WNr] to point(343, 245)
    end if
    if Ok = 1 then
      OnPos[WNr] = 1
    end if
    if Ok = 0 then
      OnPos[WNr] = 0
    end if
  end if
  if (WNr = 2) or (WNr = 4) then
    Ok = 0
    if (tx > (264 - t)) and (tx < (264 + t)) and (ty > (248 - t)) and (ty < (248 + t)) then
      Ok = 1
    end if
    if (WNr = 4) and (OnPos[2] = 0) then
      Ok = 0
    end if
    if Ok = 0 then
      set the loc of sprite WheelSpriteNr[WNr] to UWheelPos[WNr]
    end if
    if Ok = 1 then
      set the loc of sprite WheelSpriteNr[WNr] to point(264, 248)
    end if
    if Ok = 1 then
      OnPos[WNr] = 1
    end if
    if Ok = 0 then
      OnPos[WNr] = 0
    end if
  end if
end
