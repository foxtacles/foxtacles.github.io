on StepMaskin
  global WTimer, WheelFrameTid, MaskinAktiv, AktWheelStep, Stong, StongDirection
  SpinWheel(2)
  SpinWheel(4)
  if AktWheelStep[2] = 0 then
    if StongDirection = -1 then
      StongDirection = 1
    else
      if StongDirection = 1 then
        StongDirection = -1
      end if
    end if
  end if
  if AktWheelStep[2] = 1 then
    puppetSound(1, "NyFx05")
  end if
  if AktWheelStep[2] = 19 then
    puppetSound(1, "TomtFx01")
  end if
  if (AktWheelStep[2] > 0) and (AktWheelStep[2] < 19) then
    SpinWheel(1)
    SpinWheel(3)
    sprite(Stong).locH = sprite(Stong).locH + (5 * StongDirection)
  end if
  WTimer = the timer + WheelFrameTid
end
