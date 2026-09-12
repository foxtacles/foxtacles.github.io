on checkNrOfBrothers
  global clockTime, numberOfBrothers, maxBrothers, LatestBrotherTime
  timeDiv = 120 / maxBrothers
  passedTime = abs(120 - clockTime)
  if clockTime > 20 then
    m = 4
  end if
  if clockTime > 50 then
    m = 3
  end if
  if clockTime > 80 then
    m = 2
  end if
  if clockTime > 100 then
    m = 1
  end if
  a = (passedTime / timeDiv) + m
  if (numberOfBrothers < a) and (LatestBrotherTime > clockTime) then
    LatestBrotherTime = clockTime
    createBrother()
  end if
end

on checkTimeOnBrothers
  global clockTime, gameObjectList, numberOfBrothers, brothersTimer, brothersActive, BrothersSenasteCast
  repeat with i = 1 to count(brothersTimer)
    if clockTime < (brothersTimer[i] - 6) then
      brothersTimer[i] = 0
      BrorNr = brothersActive[i]
      tObj = gameObjectList[BrorNr]
      posX = tObj.posX
      posY = tObj.posY
      NyCS = 6
      if getAt(BrothersSenasteCast, BrorNr - 2) = 1 then
        NyCS = 6
      end if
      if getAt(BrothersSenasteCast, BrorNr - 2) = 4 then
        NyCS = 7
      end if
      if tObj.aktivAction = 3 then
        return 
      end if
      UNIcreateUniObject(BrorNr, 6, 1, [point(posX, posY)], NyCS)
    end if
  end repeat
end

on createBrother
  global numberOfBrothers, brothersPosListFree, brothersPosListActive, brothersPosList, brothersFree, brothersActive, brothersTimer, chainList, clockTime, LastArc, BrothersSenasteCast
  if (count(brothersFree) = 0) or (count(brothersPosListFree) = 0) then
    return 
  end if
  numberOfBrothers = numberOfBrothers + 1
  Nr = count(brothersFree)
  pick = random(Nr)
  brother = brothersFree[pick]
  deleteAt(brothersFree, pick)
  add(brothersActive, brother)
  add(brothersTimer, clockTime)
  theSize = count(brothersPosListFree)
  arcOk = 0
  ggr = 0
  repeat while arcOk = 0
    thePos = random(theSize)
    thearc = brothersPosListFree[thePos]
    ggr = ggr + 1
    if thearc <> LastArc then
      arcOk = 1
    end if
    if ggr = 600 then
      arcOk = 1
    end if
  end repeat
  deleteAt(brothersPosListFree, thePos)
  LastArc = thearc
  thePosList = brothersPosList[thearc]
  thePosListSize = count(thePosList)
  thePointInTheArc = random(thePosListSize)
  thepoint = thePosList[thePointInTheArc]
  pointUsed = [thearc, thePointInTheArc, brother]
  add(brothersPosListActive, pointUsed)
  CS = 1
  SS = 1
  chainPos = brother - 2 + 14
  if random(2) = 1 then
    CS = 4
    chainPos = chainPos + 5
    SS = 2
  end if
  setAt(BrothersSenasteCast, brother - 2, CS)
  theChainList = chainList[chainPos]
  theChainList[4] = [thepoint]
  UNIcreateUniObject(brother, 6, 1, [thepoint], CS, [chainPos], SS)
end
