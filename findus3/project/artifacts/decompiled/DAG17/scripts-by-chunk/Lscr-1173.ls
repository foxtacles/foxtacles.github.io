on moveGravity stopX, castMemberNum, steps, currentSprite
  global ballSize, ballBroke, ballBreakOnStep, startX, startY, stopY, gravity, animationCounter, totalAnimationTime, velXstart, velYstart, elkSpriteNumber, splatRemoveTime, elkAlive, elkSpeed, ElkHitCast, ElkDirection, numberOfPlayers, LitenFigTimer, LitenFigAktiv
  dx = stopX - startX
  velXstart = float(dx / totalAnimationTime)
  newX = (velXstart * animationCounter) + startX
  newY = (0.5 * gravity * animationCounter * animationCounter) + (velYstart * animationCounter) + startY
  if animationCounter >= totalAnimationTime then
    newX = stopX
    newY = stopY
    thisStep = steps
    returnValue = 0
  else
    pictureDuration = totalAnimationTime / float(steps)
    thisStep = TRUNCATE(animationCounter / pictureDuration)
    returnValue = 1
  end if
  if thisStep = 9 then
    if (the locH of sprite currentSprite > 50) and (abs(the locH of sprite currentSprite - the locH of sprite elkSpriteNumber) < 55) then
      ADDSCORE("player", 1)
      if numberOfPlayers = 1 then
        if ElkDirection = 1 then
          set the memberNum of sprite elkSpriteNumber to member(ElkHitCast, "graphics")
        else
          t = ElkHitCast + 1
          set the memberNum of sprite elkSpriteNumber to member(t, "graphics")
        end if
      else
        set the memberNum of sprite elkSpriteNumber to member(ElkHitCast, "graphics")
      end if
      LitenFigTimer = the timer + 55
      LitenFigAktiv = 1
      sprite(65).member = member(55, "Graphics")
      returnValue = 0
      set the loc of sprite 35 to the loc of sprite currentSprite
      splatRemoveTime = the timer + 20
      elkAlive = 0
    else
      if abs(the locH of sprite currentSprite - 25) < 25 then
        returnValue = 0
        set the loc of sprite 35 to the loc of sprite currentSprite
        splatRemoveTime = the timer + 20
      else
        sprite(currentSprite).locZ = 3
        sprite(31).locZ = 3
        sprite(32).locZ = 3
      end if
    end if
  end if
  ratio = 14 - thisStep
  newSize = ballSize * ratio / 14
  if ballBroke = 0 then
    set the width of sprite currentSprite to newSize
    set the height of sprite currentSprite to newSize
    set the locH of sprite currentSprite to newX
    set the locV of sprite currentSprite to newY
  else
    set the width of sprite (currentSprite + 6) to newSize
    set the height of sprite (currentSprite + 6) to newSize
    set the width of sprite (currentSprite + 7) to newSize
    set the height of sprite (currentSprite + 7) to newSize
    set the locH of sprite (currentSprite + 6) to newX + (ballBroke * 4)
    set the locV of sprite (currentSprite + 6) to newY
    set the locH of sprite (currentSprite + 7) to newX - (ballBroke * 4)
    set the locV of sprite (currentSprite + 7) to newY
    ballBroke = ballBroke + 0.10000000000000001
  end if
  return returnValue
end

on TRUNCATE input
  if input = 0 then
    return 0
  else
    if input > 0 then
      return integer(input - 0.5)
    else
      return integer(input + 0.5)
    end if
  end if
end

on changePicture startCastNumber, stopCastNumber, direction, spriteNumber, counter, counterChangeValue
  counter = counter + 1
  if counter = counterChangeValue then
    counter = 1
    set the memberNum of sprite spriteNumber to the memberNum of sprite spriteNumber + direction
    if the memberNum of sprite spriteNumber > stopCastNumber then
      set the memberNum of sprite spriteNumber to startCastNumber
    else
      if the memberNum of sprite spriteNumber < startCastNumber then
        set the memberNum of sprite spriteNumber to stopCastNumber
      end if
    end if
  end if
  return counter
end

on changePicture2 startCastNumber, stopCastNumber, direction, spriteNumber, counter, counterChangeValue, Antalggr
  counter = counter + 1
  if counter = counterChangeValue then
    if Antalggr = 0 then
      set the memberNum of sprite spriteNumber to startCastNumber
    end if
    Antalggr = Antalggr + 1
    counter = 1
    set the memberNum of sprite spriteNumber to the memberNum of sprite spriteNumber + direction
  end if
  return counter
end
