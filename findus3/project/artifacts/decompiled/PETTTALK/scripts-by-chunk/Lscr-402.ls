on KollaOmJaNejDjurAktiv
  global AktRitning, JaDjurSpriteNr, NejDjurSpriteNr, AntalJaNejDjurggr
  if AntalJaNejDjurggr > -1 then
    MoveJaNejDjur()
    if (the mouseDown = 1) and (rollOver(JaDjurSpriteNr) = 1) then
      TaFramBortPettson(3)
    end if
    if (the mouseDown = 1) and (rollOver(NejDjurSpriteNr) = 1) then
      updateStage()
      TaFramBortPettson(2)
    end if
  end if
end
