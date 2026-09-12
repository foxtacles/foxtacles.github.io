on UNIfixSteps objNumber, thisMotion
  global UNIObjectList
  tObj = getAt(UNIObjectList, objNumber)
  thePath = tObj.UNIpathList
  startX = tObj.UNIaktX
  startY = tObj.UNIaktY
  startPoint = point(startX, startY)
  listPos = getPos(thePath, startPoint)
  listCount = count(thePath)
  direction = tObj.UNIpathDirection
  stepSize = tObj.UNIpixelsPerStep
  if (listPos = listCount) and (thisMotion = 1) then
    nextPos = listCount - 1
  else
    if (listPos = 1) and (thisMotion = 1) then
      nextPos = 2
    else
      if (listPos = listCount) and (thisMotion = 2) then
        nextPos = 1
      else
        nextPos = listPos + direction
      end if
    end if
  end if
  if nextPos < 1 then
    nothing()
  end if
  stopPoint = getAt(thePath, nextPos)
  stopX = stopPoint.locH
  stopY = stopPoint.locV
  xDist = float(stopX - startX)
  yDist = float(stopY - startY)
  totalDist = sqrt((xDist * xDist) + (yDist * yDist))
  extra = integer(totalDist) mod stepSize
  steps = integer(totalDist) / stepSize
  if extra <> 0 then
    steps = steps + 1
  end if
  dx = xDist / float(steps)
  dy = yDist / float(steps)
  tObj.UNInumberOfSteps = steps
  tObj.UNIDX = dx
  tObj.UNIDY = dy
  tObj.UNIStopX = stopX
  tObj.UNIStopY = stopY
end
