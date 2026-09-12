on FortsattEfterTomte
  global startsprites, endsprites, tomtepos, TomteSprites, huvud, musch, kropp, skor, Ljud
  if TomteSprites[2] = TomteSprites[3] then
    TomteSprites[3] = 0
  end if
  repeat with i = startsprites[1] to endsprites[5]
    set the loc of sprite i to point(-1000, -1000)
  end repeat
  puppetSound(2, 0)
  go("forts")
end
