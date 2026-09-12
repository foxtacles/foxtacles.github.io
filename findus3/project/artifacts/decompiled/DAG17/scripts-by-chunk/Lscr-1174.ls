global elkCounter, startElk, endElk, movedElkCounter, elkSpeed, changeElkPictureSpeed, startElkSpeed, elkSpriteNumber, startElkCastNumber, stopElkCastNumber, numberOfPlayers, ElkDirection, targetPos, standCounter, elkLock, ballSpriteNumber, findusSpriteNumber, elkAlive, currentScorePlayer, currentScoreElk

on moveElk
  if elkAlive = 0 then
    return 
  end if
  if numberOfPlayers = 1 then
    autoElk2()
    return 
  end if
  movedElkCounter = movedElkCounter + 1
  if (keyPressed(123) or keyPressed(0)) and (keyPressed(124) or keyPressed(2)) then
    movedElkCounter = 1
    return 
  else
    if keyPressed(123) or keyPressed(0) then
      ElkDirection = -1
      movedElkCounter = 1
    else
      if keyPressed(124) or keyPressed(2) then
        ElkDirection = 1
        movedElkCounter = 1
      else
        if ((movedElkCounter + random(50)) > 120) and (the memberNum of sprite elkSpriteNumber = stopElkCastNumber) then
          movedElkCounter = -10
          return 
        else
          if movedElkCounter = 0 then
            set the memberNum of sprite elkSpriteNumber to stopElkCastNumber
            return 
          else
            return 
          end if
        end if
      end if
    end if
  end if
  if the memberNum of sprite elkSpriteNumber = (stopElkCastNumber + 1) then
    set the memberNum of sprite elkSpriteNumber to stopElkCastNumber
    movedElkCounter = 1
  end if
  Faktor = currentScorePlayer - currentScoreElk
  if Faktor > 4 then
    elkSpeed = 4
  end if
  if Faktor > 8 then
    elkSpeed = 6
  end if
  elkCounter = changePicture(startElkCastNumber, stopElkCastNumber, ElkDirection, elkSpriteNumber, elkCounter, changeElkPictureSpeed)
  set the locH of sprite elkSpriteNumber to the locH of sprite elkSpriteNumber + (ElkDirection * elkSpeed)
  if the locH of sprite elkSpriteNumber >= endElk then
    ADDSCORE("elk", 1)
    elkSpeed = startElkSpeed
    set the locH of sprite elkSpriteNumber to startElk
  else
    if the locH of sprite elkSpriteNumber < startElk then
      set the locH of sprite elkSpriteNumber to startElk
    end if
  end if
end

on autoElk2
  global standTime, ballALive, elkLock, checkLock, ballLoopCounter, elkggr, ElkAtStart, currentScoreElk, currentScorePlayer
  thisElkPos = the locH of sprite elkSpriteNumber
  thisBallPosY = the locV of sprite ballSpriteNumber
  thisBallPosX = the locH of sprite ballSpriteNumber
  posDiff = abs(thisBallPosX - thisElkPos)
  if ElkAtStart = 1 then
    ElkAtStart = 0
    movedElkCounter = 0
    targetPos = random(100) + 100
    Faktor = currentScorePlayer - currentScoreElk
    if Faktor < 1 then
      Faktor = 1
    end if
    if Faktor > 7 then
      Faktor = 7
    end if
    St = random(2)
    if St = 1 then
      put "1"
      ElkDirection = 1
      startElk = -100
      endElk = 730
    end if
    if St = 2 then
      put "2"
      ElkDirection = -1
      startElk = 730
      endElk = -100
    end if
    thisElkPos = startElk
    elkSpeed = startElkSpeed - 2 + random(2) + Faktor
    nextLoch = thisElkPos + (ElkDirection * elkSpeed)
  else
    elkggr = elkggr + 1
    if (elkggr mod 15) = 0 then
    end if
    nextLoch = thisElkPos + (ElkDirection * elkSpeed)
    if ElkDirection = 1 then
      if nextLoch >= endElk then
        ADDSCORE("elk", 1)
        nextLoch = startElk
        ElkAtStart = 1
      end if
    end if
    if ElkDirection = -1 then
      if nextLoch <= endElk then
        ADDSCORE("elk", 1)
        nextLoch = startElk
        ElkAtStart = 1
      end if
    end if
  end if
  movedElkCounter = movedElkCounter + 1
  if movedElkCounter > 1 then
    movedElkCounter = 0
    if ElkDirection = 1 then
      elkCounter = changePicture(startElkCastNumber, stopElkCastNumber, ElkDirection, elkSpriteNumber, elkCounter, changeElkPictureSpeed)
    else
      elkCounter = changePicture(startElkCastNumber + 7, stopElkCastNumber + 7, ElkDirection, elkSpriteNumber, elkCounter, changeElkPictureSpeed)
    end if
  end if
  set the locH of sprite elkSpriteNumber to nextLoch
end

on setNewTargetPos
  whichWay = random(4)
  case whichWay of
    1, 2, 3, 4:
      nextTarget = targetPos + random(100) + 100
      elkSpeed = startElkSpeed - 3 + random(2)
      ElkDirection = 1
    otherwise:
      nextTarget = targetPos - random(60) - 20
      elkSpeed = startElkSpeed - 2 + random(2)
      ElkDirection = -1
      if nextTarget <= startElk then
        nextTarget = targetPos + random(100) + 60
        ElkDirection = 1
      end if
  end case
  targetPos = nextTarget
end

on setNewTargetPosEVADE
  global changeInstopX, stopX, rightCurveNr, leftCurveNr
  elkSpeed = 2
  elkLoch = the locH of sprite elkSpriteNumber
  ballLoch = the locH of sprite ballSpriteNumber
  guessPosBall = stopX + (changeInstopX * 56)
  guessPosElk = elkLoch + (ElkDirection * 40)
  if abs(guessPosBall - guessPosElk) <= 40 then
    ElkDirection = -ElkDirection
    dirSign = abs(ElkDirection) / ElkDirection
    nextTarget = elkLoch + (30 * dirSign) + (20 * random(2) * dirSign)
    if (dirSign = -1) and (random(5) = 1) then
      nextTarget = elkLoch + 80 + (20 * random(2))
      ElkDirection = 1
      elkSpeed = 4
    end if
  else
    nextTarget = elkLoch + 60 + (20 * random(2))
    ElkDirection = 1
  end if
  targetPos = integer(nextTarget)
  return 
end

on autoElk
  global standTime, ballALive, elkLock, checkLock, ballLoopCounter
  thisElkPos = the locH of sprite elkSpriteNumber
  thisBallPosY = the locV of sprite ballSpriteNumber
  thisBallPosX = the locH of sprite ballSpriteNumber
  posDiff = abs(thisBallPosX - thisElkPos)
  if thisElkPos > 470 then
    elkCounter = changePicture(startElkCastNumber, stopElkCastNumber, ElkDirection, elkSpriteNumber, elkCounter, changeElkPictureSpeed)
    nextLoch = thisElkPos + 3
    if nextLoch >= endElk then
      ADDSCORE("elk", 1)
      nextLoch = startElk
    end if
    set the locH of sprite elkSpriteNumber to nextLoch
    return 
  end if
  if (ballALive = 1) and (ballLoopCounter >= 26) and (posDiff < 70) and (checkLock = 0) and (elkLock = 0) then
    elkLock = 1
  end if
  if elkLock = 1 then
    nextLoch = thisElkPos + ElkDirection
    elkCounter = changePicture(startElkCastNumber, stopElkCastNumber, ElkDirection, elkSpriteNumber, elkCounter, changeElkPictureSpeed)
    set the locH of sprite elkSpriteNumber to nextLoch
    if ballLoopCounter > 35 then
      elkLock = 0
      setNewTargetPosEVADE()
      checkLock = 1
    end if
    return 
  end if
  if thisElkPos = startElk then
    ElkDirection = 1
    targetPos = random(100) + 100
    elkSpeed = startElkSpeed - 2 + random(2)
    nextLoch = thisElkPos + (ElkDirection * elkSpeed)
  else
    if thisElkPos = targetPos then
      standCounter = standCounter + 1
      standTime = random(15) + 20
      if standCounter > standTime then
        setNewTargetPos()
        nextLoch = thisElkPos + (ElkDirection * elkSpeed)
        standCounter = 1
      else
        nextLoch = thisElkPos
        return 
      end if
    else
      if (thisElkPos < targetPos) and (ElkDirection = 1) then
        nextLoch = thisElkPos + (ElkDirection * elkSpeed)
        if nextLoch >= targetPos then
          nextLoch = targetPos
        end if
      else
        if (thisElkPos > targetPos) and (ElkDirection = -1) then
          nextLoch = thisElkPos + (ElkDirection * elkSpeed)
          if nextLoch <= targetPos then
            nextLoch = targetPos
          end if
        end if
      end if
    end if
  end if
  if nextLoch >= endElk then
    ADDSCORE("elk", 1)
    nextLoch = startElk
  end if
  elkCounter = changePicture(startElkCastNumber, stopElkCastNumber, ElkDirection, elkSpriteNumber, elkCounter, changeElkPictureSpeed)
  set the locH of sprite elkSpriteNumber to nextLoch
end
