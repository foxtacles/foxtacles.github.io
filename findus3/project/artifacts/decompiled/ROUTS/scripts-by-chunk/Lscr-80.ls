global G_PoangSpNr, G_PoangCNr, G_PoangAntalSiffror, G_ElkHigh, G_AktSparaFigur, G_AktGame, G_SpikHigh, G_BrorHigh, G_TomteMirror, G_SparaFigSpNr, G_SparaFigCnr, OkAttKlickaTillArea, TaBortTitelText

on InitPoangTomte GameNr, SpNr, CastNR, TwoThreeDigit, Mirror
  G_PoangSpNr = SpNr
  G_PoangCNr = CastNR
  G_PoangAntalSiffror = TwoThreeDigit
  G_AktGame = GameNr
  G_TomteMirror = Mirror
  InitSparaFigur(G_PoangSpNr + 17, G_PoangCNr + 2)
end

on ShowPoangtomte Typ
  Xx = 0
  if G_TomteMirror = 1 then
    Xx = 277
  end if
  FigOffset = [point(61 - Xx, -53), point(162 - Xx, -53), point(61 - Xx, -4), point(162 - Xx, -4)]
  if G_AktGame = 3 then
    PoangH = G_ElkHigh
  end if
  if G_AktGame = 4 then
    PoangH = G_SpikHigh
  end if
  if G_AktGame = 5 then
    PoangH = G_BrorHigh
  end if
  if (Typ = 1) and (PoangH[1][1] = 0) then
    Typ = 0
  end if
  if Typ = 0 then
    sprite(G_PoangSpNr).member = member(G_PoangCNr, "Graphics")
    repeat with LoopP = 1 to 16
      sprite(G_PoangSpNr + LoopP).loc = point(-1000, -1000)
    end repeat
  else
    CNr = G_PoangCNr + 1
    sprite(G_PoangSpNr).member = member(CNr, "Graphics")
    UrPos = sprite(G_PoangSpNr).loc
    repeat with LoopP = 1 to 4
      SpNr = G_PoangSpNr + 1 + ((LoopP - 1) * 4)
      if PoangH[LoopP][1] > 0 then
        CNr = G_PoangCNr + 1 + PoangH[LoopP][1]
        sprite(SpNr).member = member(CNr, "Graphics")
        sprite(SpNr).loc = UrPos + FigOffset[LoopP]
      end if
      Poang = PoangH[LoopP][2]
      N1 = Poang / 100
      n2 = (Poang - (N1 * 100)) / 10
      n3 = Poang - (N1 * 100) - (n2 * 10)
      Cnr1 = G_PoangCNr + 1 + 5 + 1 + N1
      CNr2 = G_PoangCNr + 1 + 5 + 1 + n2
      Cnr3 = G_PoangCNr + 1 + 5 + 1 + n3
      sprite(SpNr + 1).member = member(Cnr1, "Graphics")
      sprite(SpNr + 2).member = member(CNr2, "Graphics")
      sprite(SpNr + 3).member = member(Cnr3, "Graphics")
      if G_PoangAntalSiffror = 3 then
        sprite(SpNr + 1).loc = UrPos + FigOffset[LoopP] + point(38, -13)
      else
        sprite(SpNr + 1).loc = point(-1000, -1000)
      end if
      sprite(SpNr + 2).loc = UrPos + FigOffset[LoopP] + point(51, -13)
      sprite(SpNr + 3).loc = UrPos + FigOffset[LoopP] + point(64, -13)
    end repeat
  end if
  updateStage()
end

on InitSparaFigur SpNr, CastN
  G_SparaFigSpNr = SpNr
  G_SparaFigCnr = CastN
end

on ShowSparaFigur Typ, Lage
  if Lage = 1 then
    FPos = point(25, 460)
  end if
  RingSp = G_SparaFigSpNr
  if G_AktSparaFigur = 0 then
    NyPos = point(-1000, -1000)
  else
    NyPos = FPos
  end if
  CNr = G_SparaFigCnr + G_AktSparaFigur - 1
  sprite(RingSp + 1).member = member(CNr, "Graphics")
  sprite(RingSp + 1).loc = NyPos
  updateStage()
end

on TaFramValAvSparaFigur
  XLage = [45, 81, 125, 174, 215, 272, 300]
  SpNr = G_SparaFigSpNr + 2
  sprite(SpNr).loc = point(320, 240)
  RensaLjud()
  puppetSound(1, "F120Ny")
  repeat while the mouseDown = 1
  end repeat
  Valgjord = -1
  updateStage()
  repeat while Valgjord = -1
    if the mouseDown = 1 then
      X = the mouseH - sprite(SpNr).left
      Y = the mouseV - sprite(SpNr).top
      repeat with cc = 1 to count(XLage - 1)
        if X > XLage[cc] then
          Valgjord = cc
        end if
      end repeat
      if (Y < 0) or (Y > 150) then
        Valgjord = 0
      end if
    end if
  end repeat
  if (Valgjord > 0) and (Valgjord <= 5) then
    G_AktSparaFigur = Valgjord
  end if
  sprite(SpNr).loc = point(-1000, -1000)
  puppetSound(1, 0)
  ShowSparaFigur(1, 1)
  repeat while the mouseDown = 1
  end repeat
  if (Valgjord > 0) and (Valgjord <= 5) and (G_AktGame = 3) then
    initvar()
  end if
  if (Valgjord > 0) and (Valgjord <= 5) and (G_AktGame = 4) then
    init()
  end if
  if (Valgjord > 0) and (Valgjord <= 5) and (G_AktGame = 5) then
    InitvarSpecialBror()
  end if
end

on TaFramValAvSparaFigurOpening Avsnitt
  XLage = [45, 81, 125, 174, 215, 272, 300]
  SpNr = G_SparaFigSpNr + 2
  sprite(SpNr).loc = point(320, 240)
  puppetSound(1, "F120Ny")
  repeat while the mouseDown = 1
    FixaFFindus()
    FixaPPettson()
    updateStage()
  end repeat
  Valgjord = -1
  updateStage()
  repeat while Valgjord = -1
    FixaFFindus()
    FixaPPettson()
    updateStage()
    if the mouseDown = 1 then
      X = the mouseH - sprite(SpNr).left
      Y = the mouseV - sprite(SpNr).top
      repeat with cc = 1 to count(XLage - 1)
        if (X > XLage[cc]) and (Y > 0) and (Y < 150) then
          Valgjord = cc
        end if
      end repeat
      if (Avsnitt = 1) and (Valgjord > 5) then
        Valgjord = -1
      end if
      if (Avsnitt <> 1) and ((Y < 0) or (Y > 150)) then
        Valgjord = 0
      end if
    end if
  end repeat
  if (Valgjord > 0) and (Valgjord <= 5) then
    G_AktSparaFigur = Valgjord
  end if
  sprite(SpNr).loc = point(-1000, -1000)
  puppetSound(1, 0)
  ShowSparaFigur(1, 1)
  OkAttKlickaTillArea = 1
  if TaBortTitelText = 1 then
    TaBortTitelText = 2
  end if
end
