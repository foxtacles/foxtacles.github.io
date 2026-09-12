on FindusIntroPrat
  global G_BrorFirstTime, SpeletBorjat
  ShowPoangtomte(1)
  if G_BrorFirstTime = 1 then
    G_BrorFirstTime = 0
    KorLjudVantaMus(1, "F501ny")
  else
    KorLjudVantaMus(1, "Spik04")
  end if
  if SpeletBorjat = 1 then
    ShowPoangtomte(0)
  end if
end
