on exitFrame
  global FangaTimer, BildTimer, HittatAktiv, SpeletSlut, AntalHittade
  if HittatAktiv = 0 then
    FixaKagla()
  end if
  if HittatAktiv = 0 then
    if the timer > FangaTimer then
      if the mouseDown = 1 then
        KollaOmMonsterFinns()
      end if
      if the mouseDown = 0 then
        SpeletSlut = 2
      end if
    end if
  end if
  if (HittatAktiv = 1) and (the timer > BildTimer) then
    TaFramHittad()
  end if
  if SpeletSlut > 0 then
    if SpeletSlut = 1 then
      TaBortDammDjur()
    end if
    go(5)
  else
    go(the frame)
  end if
end
