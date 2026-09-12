on exitFrame
  global IntroSound, KonstruktionFardig, SmaDjurIsJumping, FraganRedanStalld, AktSmaDjurBild, SmaDjur1Sprite, SmaDjur2Sprite, m, AktRitning
  if the mouseDown = 1 then
    KOllaKonstrukKnapp()
  end if
  KollaOmJaNejDjurAktiv()
  if (the mouseH >= the left of sprite 9) and (the mouseH <= the right of sprite 9) and (the mouseV >= the top of sprite 9) and (the mouseV <= the bottom of sprite 9) and (the mouseDown = 1) then
    OnOff()
  end if
  if (IntroSound = 0) and (the timer > 600) then
    TaFramBortPettson(4)
    IntroSound = 1
  end if
  if (KonstruktionFardig = 1) and (FraganRedanStalld = 0) then
    FraganRedanStalld = 1
    AktRitning = AktRitning + 1
    if AktRitning > 3 then
      AktRitning = 1
    end if
    TaFramBortPettson(6)
  end if
  go(the frame)
end
