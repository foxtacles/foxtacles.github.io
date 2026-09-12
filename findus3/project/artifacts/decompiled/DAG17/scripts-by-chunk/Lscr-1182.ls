on FixaFindusIntro Typ
  global G_ElkFirstTime
  if Typ = 1 then
    ShowPoangtomte(1)
    if G_ElkFirstTime = 1 then
      G_ElkFirstTime = 0
      KorLjudVantaMus(1, "F301")
    else
      KorLjudVantaMus(1, "F301b")
    end if
    ShowPoangtomte(0)
  end if
  if Typ = 2 then
    ShowPoangtomte(0)
    KorLjudVantaMus(1, "F302")
  end if
end
