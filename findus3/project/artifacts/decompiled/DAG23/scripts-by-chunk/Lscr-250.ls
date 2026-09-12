global gPath, gPathLen, gPathPos, gPathDist, gNumObjects, gOldX, gOldY, gDragX, gDragY, gSortList, gEditSortList, gObjectList, gFindus, gFindusGhost, gGran, gLastTicks

on exitFrame
  checkButtons()
  checkSound()
  t = the timer
  deltaTicks = t - gLastTicks
  gLastTicks = t
  if deltaTicks <= 6 then
    spd = 1
  else
    if deltaTicks <= 8 then
      spd = 2
    else
      if deltaTicks <= 14 then
        spd = 3
      else
        spd = 4
      end if
    end if
  end if
  r = the rect of sprite gFindus.spriteNum
  p = point(the mouseH, the mouseV)
  if inside(p, r) then
    cursor(list(28, 29))
  else
    checkCursor()
  end if
  positionObjects()
  sortObjects(10, gSortList)
  gPathPos = gPathPos + spd
  if gPathPos > gPathLen then
    gPathPos = gPathPos - gPathLen
  end if
  gPathPos = max(1, min(gPathLen, gPathPos))
  if the mouseDown and inside(p, r) then
    repeat with i = 13 to 15
      sprite(i).visible = 0
    end repeat
    setpos(gFindusGhost, gFindus.currpos)
    gFindusGhost.castNum = 13
    gOldX = -1
    gOldY = -1
    gDragX = the mouseH - gFindus.currpos.locH
    gDragY = the mouseV - gFindus.currpos.locV
    X = max(80, min(560, the mouseH - gDragX))
    Y = max(150, min(400, the mouseV - gDragY))
    gPathPos = 1
    gPathLen = 1
    setAt(gPath, gPathPos, point(X, Y))
    gOldX = X
    gOldY = Y
    sortObjects(10, gEditSortList)
    cursor([37, 38])
    go("dragging")
  else
    go(the frame)
  end if
end
