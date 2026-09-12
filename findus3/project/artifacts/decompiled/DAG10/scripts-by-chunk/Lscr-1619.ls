global G_AktSparaFigur, AntalPoang, SpeletBorjat, clockTime

on endGame
  RensaLjud()
  puppetSound(1, "Dong")
  repeat while soundBusy(1)
  end repeat
  if AntalPoang < 30 then
    KorLjudOchVanta(1, "F208")
    ingetintroprat = 0
  end if
  if (AntalPoang > 29) and (AntalPoang < 70) then
    L = random(2)
    if L = 1 then
      KorLjudOchVanta(1, "F205ny")
    end if
    if L = 2 then
      KorLjudOchVanta(1, "F203br")
    end if
    KorLjudOchVanta(1, "ProvIgen")
    ingetintroprat = 0
  end if
  if (AntalPoang > 69) and (AntalPoang < 140) then
    L = random(2)
    if L = 1 then
      KorLjudOchVanta(1, "F204br")
    end if
    if L = 2 then
      KorLjudOchVanta(1, "F206")
    end if
    KorLjudOchVanta(1, "ProvIgen")
    ingetintroprat = 0
  end if
  if AntalPoang > 139 then
    KorLjudOchVanta(1, "F207br")
    ingetintroprat = 1
  end if
  initvar()
  SpeletBorjat = 0
  if ingetintroprat = 0 then
    FindusIntroPrat()
  end if
  fixClock(clockTime)
end
