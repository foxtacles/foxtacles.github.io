on InitObjekt
  global lSpikObjMatris, clSpikSpriteNum, cFartSlumpRange
  tempObj = new(script("spik"), 1, getAt(clSpikSpriteNum, 1), 120, 115, [5, random(cFartSlumpRange), 0], [-4, 0, -15], [120, 660, 100], [0, 0], [52, 52, 64, 58], [5, 5, 4], [0, 0, 0], [5, 10, 30])
  add(lSpikObjMatris, tempObj)
  tempObj = new(script("spik"), 1, getAt(clSpikSpriteNum, 2), 120, 180, [5, random(cFartSlumpRange), 0], [-1, 0, -15], [120, 660, 100], [0, 0], [52, 52, 64, 58], [5, 5, 4], [0, 0, 0], [5, 10, 30])
  add(lSpikObjMatris, tempObj)
  tempObj = new(script("spik"), 1, getAt(clSpikSpriteNum, 3), 120, 240, [5, random(cFartSlumpRange), 0], [2, 0, -15], [120, 660, 100], [0, 0], [52, 52, 64, 58], [5, 5, 4], [0, 0, 0], [5, 10, 30])
  add(lSpikObjMatris, tempObj)
  tempObj = new(script("spik"), 1, getAt(clSpikSpriteNum, 4), 120, 310, [5, random(cFartSlumpRange), 0], [5.5, 0, -15], [120, 660, 100], [0, 0], [52, 52, 64, 58], [5, 5, 4], [0, 0, 0], [5, 10, 30])
  add(lSpikObjMatris, tempObj)
end
