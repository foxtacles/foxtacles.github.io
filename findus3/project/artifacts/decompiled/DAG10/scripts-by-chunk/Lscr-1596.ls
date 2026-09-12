on mainLoop
  global gameObjectList, SpeletSlut, bUniReturn, UNIObjectList, SpeletBorjat, FigTitt
  FrameTimer = the timer + 1
  aa = gameObjectList[1].aktiv
  bb = gameObjectList[2].aktiv
  cc = gameObjectList[8].aktiv
  if (bb = 1) and (FigTitt = 0) then
    FigTitt = 1
    sprite(6).member = member(18, "Graphics")
  end if
  if (bb = 0) and (FigTitt = 1) then
    FigTitt = 0
    sprite(6).member = member(19, "Graphics")
  end if
  if aa = 0 then
    moveFindus()
    if (SpeletSlut = 0) and (SpeletBorjat = 1) then
      checkMouse(bb, cc)
    end if
    if (SpeletBorjat = 0) and (the mouseDown = 1) then
      SpeletBorjat = 1
      ShowPoangtomte(0)
    end if
  end if
  if (bb = 0) and (cc = 1) then
    checkForHit(21)
  else
    if (cc = 0) and (bb = 1) then
      checkForHit(20)
    else
      if (cc = 1) and (bb = 1) then
        checkForHit(20)
        checkForHit(21)
      end if
    end if
  end if
  if (SpeletSlut = 0) and (SpeletBorjat = 1) then
    checkClock()
    checkNrOfBrothers()
    checkTimeOnBrothers()
  end if
  if (aa = 0) and (bb = 0) and (cc = 0) and (SpeletSlut = 1) then
    SpeletSlut = 2
  end if
  updateGameObjects()
  repeat while the timer < FrameTimer
  end repeat
end
