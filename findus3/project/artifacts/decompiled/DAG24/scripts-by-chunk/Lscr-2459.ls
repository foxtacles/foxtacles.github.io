on exitFrame
  global MaskinAktiv, WTimer, WheelSpriteNr, OnPos
  if (OnPos = [1, 1, 1, 1]) and (MaskinAktiv = 0) then
    repeat with i = 1 to 4
      set the moveableSprite of sprite WheelSpriteNr[i] to 0
    end repeat
    StartaMaskin()
    puppetSound(2, "P710")
    DisplayDragDjur(3)
  end if
  if MaskinAktiv and (the timer > WTimer) then
    StepMaskin()
  end if
  go(the frame)
end
