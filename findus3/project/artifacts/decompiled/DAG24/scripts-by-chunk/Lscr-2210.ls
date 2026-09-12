on getTomtePos SpriteNr
  global tomtepos, tomtesprite
  a = getOne(tomtepos, sprite(SpriteNr).memberNum)
  if a <> 0 then
    return sprite(tomtesprite).loc - tomtepos[a + 1]
  end if
  return point(-1000, -1000)
end
