on Initram
  global clSpikSpriteNum, cXMusTolerans, cYMusTolerans
end

on PosRam
  global clSpikSpriteNum, cXMusTolerans, cYMusTolerans
  repeat with i = 1 to 4
    temp = the loc of sprite getAt(clSpikSpriteNum, i)
    tempX = getAt(temp, 1) - cXMusTolerans
    tempY = getAt(temp, 2) - cYMusTolerans
    set the loc of sprite (109 + i) to point(tempX, tempY)
  end repeat
end
