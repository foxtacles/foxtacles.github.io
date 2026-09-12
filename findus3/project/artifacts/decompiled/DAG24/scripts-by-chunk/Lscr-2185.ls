on exitFrame
  global TomteMoveTimer, Tomteggr, startsprites, tomtepos, TomteSprites
  puppetSound(1, "Ber05c")
  TomteMoveTimer = the timer + 200
  Tomteggr = 1
  NyPos = point(550, 273)
  sprite(startsprites[1]).loc = NyPos
  repeat with i = 1 to 4
    pos = getOne(tomtepos, TomteSprites[i])
    posDiff = tomtepos[pos + 1]
    sprite(TomteSprites[i]).loc = NyPos - posDiff
  end repeat
  repeat with i = 42 to 80
    set the moveableSprite of sprite i to 0
  end repeat
  InitDragAvsnitt(4)
  DisplayDragDjur(1)
end
