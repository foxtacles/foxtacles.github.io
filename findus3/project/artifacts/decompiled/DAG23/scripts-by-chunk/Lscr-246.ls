global gPath, gPathLen, gPathPos, gPathDist, gNumObjects, gOldX, gOldY, gDragX, gDragY, gSortList, gEditSortList, gObjectList, gFindus, gFindusGhost, gGran

on exitFrame
  checkButtons()
  checkSound()
  if the mouseDown then
    X = max(80, min(560, the mouseH - gDragX))
    Y = max(150, min(400, the mouseV - gDragY))
    if (X <> gOldX) or (Y <> gOldY) then
      gPathLen = min(10000, gPathLen + 1)
      gPathPos = gPathPos + 1
      if gPathPos > gPathLen then
        gPathPos = gPathPos - gPathLen
      end if
      setpos(gFindus, point(X, Y))
      setAt(gPath, gPathPos, point(X, Y))
      gOldX = X
      gOldY = Y
    end if
    sortObjects(10, gEditSortList)
    go(the frame)
  else
    if gPathLen <= 0 then
      gPathLen = 1
      gPathPos = 1
    end if
    repeat with i = 13 to 15
      sprite(i).visible = 1
    end repeat
    gFindusGhost.castNum = 41
    go("gameloop")
  end if
end
