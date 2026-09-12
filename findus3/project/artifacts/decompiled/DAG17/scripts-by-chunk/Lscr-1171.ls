global curveLimit, ballALive, ballSpeed, gravity, startX, startY, stopX, stopY, velYstart, ballCastNumber, animationCounter, animationCounterStart, oldMilliseconds, totalAnimationTime, startMouseH, newMouseH, mouseMoved, elkCounter, findusCounter, elkSpeed, findusStep, maxFindusRight, maxFindusLeft, changeInstopX, curveFactor, targetHeight, startElk, elkSpriteNumber, ballSpriteNumber, findusSpriteNumber, startFindusCastNumber, stopFindusCastNumber, changeElkPictureSpeed, ballLoopCounter, ballBreakOnStep, ballBroke, AnimFindusCastStart, AnimFindusCastStop, FindusState, AnimFindusCounter, AntalAnimggr, FindusSpeed, MusSlapptKnapp, ElkGameOver, LitenFigTimer, LitenFigAktiv

on mainLoop
  moveElk()
  if FindusState = 1 then
    moveFindus()
  else
    AnimFindus()
  end if
  checkSplat()
  if ballALive = 0 then
    if ElkGameOver = 0 then
      checkMouse()
    end if
  else
    CHECKCURVE()
    checkBall()
  end if
  if ElkGameOver = 0 then
    checkClock()
  end if
  if (the timer > LitenFigTimer) and (LitenFigAktiv = 1) then
    LitenFigAktiv = 1
    sprite(65).member = member(54, "Graphics")
  end if
end

on removeBall
  global checkLock, rightCurveNr, leftCurveNr, ballBroke
  checkLock = 0
  animationCounter = animationCounterStart
  changeInstopX = 0
  mouseMoved = 0
  ballLoopCounter = 1
  sprite(ballSpriteNumber).locZ = 25
  sprite(ballSpriteNumber + 6).locZ = 31
  sprite(ballSpriteNumber + 7).locZ = 32
  if ballBroke <> 0 then
    set the loc of sprite (ballSpriteNumber + 6) to point(-500, -500)
    set the loc of sprite (ballSpriteNumber + 7) to point(-500, -500)
    ballBroke = 0
    ballBreakOnStep = -1
  else
    set the loc of sprite ballSpriteNumber to point(-500, -500)
  end if
end

on ADDSCORE player, increment
  global currentScoreElk, currentScorePlayer
  case player of
    "Reset":
      set the memberNum of sprite 15 to 112
      set the memberNum of sprite 16 to 112
      set the memberNum of sprite 13 to 112
      set the memberNum of sprite 14 to 112
    "elk":
      currentScoreElk = currentScoreElk + increment
      if increment = 0 then
        currentScoreElk = 0
      end if
      n2 = currentScoreElk mod 10
      N1 = (currentScoreElk - n2) / 10
      set the memberNum of sprite 15 to 112 + N1
      set the memberNum of sprite 16 to 112 + n2
      puppetSound(1, "Pling")
    "player":
      currentScorePlayer = currentScorePlayer + increment
      if increment = 0 then
        currentScorePlayer = 0
      end if
      n2 = currentScorePlayer mod 10
      N1 = (currentScorePlayer - n2) / 10
      set the memberNum of sprite 13 to 112 + N1
      set the memberNum of sprite 14 to 112 + n2
      TypLjud = random(3)
      if TypLjud = 3 then
        Ljud = random(3)
        if Ljud = 1 then
          puppetSound(2, "Hit01ny")
        end if
        if Ljud = 2 then
          puppetSound(2, "Hit02ny")
        end if
        if Ljud = 3 then
          puppetSound(2, "Hit03ny")
        end if
      else
        puppetSound(2, "Traff2ny")
      end if
  end case
end

on CHECKCURVE
  global checkingFraction
  oldmouseH = newMouseH
  newMouseH = the mouseH
  if newMouseH = startMouseH then
    newMouseH = oldmouseH
    return 
  end if
  mouseMoved = newMouseH - startMouseH
  if abs(mouseMoved) > curveLimit then
    mouseMoved = curveLimit * (mouseMoved / abs(mouseMoved))
  end if
  distancefactor = 1.0
  changeInstopX = changeInstopX + (mouseMoved * curveFactor * distancefactor)
end

on checkMouse
  if (the mouseDown = 1) and (MusSlapptKnapp = 1) and (ballALive = 0) then
    MusSlapptKnapp = 0
    startMouseH = the mouseH
    newMouseH = startMouseH
    startX = the locH of sprite findusSpriteNumber + 40
    startY = the locV of sprite findusSpriteNumber - (the height of sprite findusSpriteNumber / 2) - 20
    stopX = the locH of sprite findusSpriteNumber
    stopY = targetHeight + random(40) - 30
    if random(10) = 1 then
      ballBreakOnStep = random(5)
    end if
    dy = stopY - startY
    velYstart = float(dy - (0.5 * gravity * totalAnimationTime * totalAnimationTime)) / float(totalAnimationTime)
    PrepareFindusAnim(2)
  else
    if the mouseDown = 0 then
      MusSlapptKnapp = 1
    end if
  end if
end

on moveFindus
  if the locH of sprite findusSpriteNumber < the mouseH then
    Fdirection = 1
  end if
  if the locH of sprite findusSpriteNumber > the mouseH then
    Fdirection = -1
  end if
  newLoch = the locH of sprite findusSpriteNumber + (findusStep * Fdirection)
  if (newLoch > maxFindusRight) or (newLoch < maxFindusLeft) or (abs(the mouseH - newLoch) <= findusStep) then
    return 
  end if
  findusCounter = changePicture(AnimFindusCastStart[1], AnimFindusCastStop[1], Fdirection, findusSpriteNumber, findusCounter, changeElkPictureSpeed)
  set the locH of sprite findusSpriteNumber to newLoch
end

on PrepareFindusAnim FindState
  AntalAnimggr = 0
  FindusState = FindState
  FindusSpeed = 5
  findusCounter = 1
end

on AnimFindus
  findusCounter = findusCounter + 1
  if findusCounter = FindusSpeed then
    findusCounter = 1
    if (FindusState = 2) and (AntalAnimggr = 3) then
      ballALive = 1
      puppetSound(3, "Kast1")
    end if
    sprite(findusSpriteNumber).memberNum = AnimFindusCastStart[FindusState] + AntalAnimggr
    AntalAnimggr = AntalAnimggr + 1
    if AntalAnimggr = (AnimFindusCastStop[FindusState] - AnimFindusCastStart[FindusState] + 1) then
      FindusState = 1
    end if
  end if
end

on checkBall
  newStopX = stopX + (changeInstopX * ballLoopCounter)
  ballALive = moveGravity(newStopX, ballCastNumber, 10, ballSpriteNumber)
  ballLoopCounter = ballLoopCounter + 1
  if ballALive = 0 then
    removeBall()
  else
    animationCounter = animationCounter + ballSpeed
  end if
end
