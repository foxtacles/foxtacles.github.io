on getStartPos SpriteNr
  global startpos
  a = getOne(startpos, SpriteNr)
  if a <> 0 then
    return startpos[a + 1]
  end if
  return point(-1000, -1000)
end
