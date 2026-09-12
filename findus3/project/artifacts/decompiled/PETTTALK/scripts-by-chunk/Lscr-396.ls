on MoveJaNejDjur
  global JaDjurSpriteNr, NejDjurSpriteNr, JaNejDjurCastNr, AntalJaNejDjurggr
  AntalJaNejDjurggr = AntalJaNejDjurggr + 1
  if AntalJaNejDjurggr > 3 then
    AntalJaNejDjurggr = 0
  end if
  puppetSprite(JaDjurSpriteNr, 1)
  puppetSprite(NejDjurSpriteNr, 1)
  set the blend of sprite JaDjurSpriteNr to 100
  set the blend of sprite NejDjurSpriteNr to 100
  if AntalJaNejDjurggr <= 2 then
    set the castNum of sprite JaDjurSpriteNr to member(JaNejDjurCastNr + AntalJaNejDjurggr, "PettTalk")
    set the castNum of sprite NejDjurSpriteNr to member(JaNejDjurCastNr + AntalJaNejDjurggr + 3, "PettTalk")
  else
    set the castNum of sprite JaDjurSpriteNr to member(JaNejDjurCastNr + (4 - AntalJaNejDjurggr), "PettTalk")
    set the castNum of sprite NejDjurSpriteNr to member(JaNejDjurCastNr + (4 - AntalJaNejDjurggr) + 3, "PettTalk")
  end if
  DelayJaNejDjur()
end

on DelayJaNejDjur
  startTimer()
  repeat while the timer < 7
    if the mouseDown = 1 then
      exit repeat
    end if
  end repeat
end
