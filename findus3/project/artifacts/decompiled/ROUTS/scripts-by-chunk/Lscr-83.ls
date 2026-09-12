on CheckHighScore GameSt, FigNr, Poang
  global G_ElkHigh, G_SpikHigh, G_BrorHigh
  if GameSt = "ELK" then
    KollPoang = G_ElkHigh
  end if
  if GameSt = "SPIK" then
    KollPoang = G_SpikHigh
  end if
  if GameSt = "BROR" then
    KollPoang = G_BrorHigh
  end if
  PlacILista = 0
  repeat with SI = 0 to 3
    if Poang > KollPoang[4 - SI][2] then
      PlacILista = 4 - SI
      if SI > 0 then
        KollPoang[4 - SI + 1][2] = KollPoang[4 - SI][2]
        KollPoang[4 - SI + 1][1] = KollPoang[4 - SI][1]
      end if
      KollPoang[4 - SI][2] = Poang
      KollPoang[4 - SI][1] = FigNr
    end if
  end repeat
  return PlacILista
end
