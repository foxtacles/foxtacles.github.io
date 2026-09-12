global ballALive, ballSpeed, startX, startY, stopX, stopY, animationCounter, animationCounterStart, oldTimer, totalAnimationTime, maxFindusRight, maxFindusLeft, findusStep, startMouseH, newMouseH, findusCounter, elkCounter, elkSpeed, curveLimit, curveFactor, targetHeight, startElk, endElk, startElkSpeed, gravity, changeInstopX, ballLoopCounter, movedElkCounter, changeElkPictureSpeed, ballSpriteNumber, elkSpriteNumber, findusSpriteNumber, mouseMoved, startElkCastNumber, stopElkCastNumber, stopBallCastNumber, ballCastNumber, stopFindusCastNumber, startFindusCastNumber, numberOfPlayers, ElkDirection, standCounter, elkLock, checkLock, rightCurveNr, leftCurveNr, ballSize, ballBroke, clockTime, nextClockChange, currentScoreElk, currentScorePlayer, splatRemoveTime, elkAlive, gameStage, counterWalk, FindusState, AnimFindusCastStart, AnimFindusCastStop, AnimFindusCounter, AntalAnimggr, ElkHitCast, ElkAtStart, MusSlapptKnapp, ElkGameOver, G_ElkFirstTime, LitenFigTimer, LitenFigAktiv

on initvar
  gameStage = 3
  if G_ElkFirstTime = 1 then
    numberOfPlayers = 1
  end if
  oldTimer = the milliSeconds
  clockTime = 121
  nextClockChange = the timer
  MusSlapptKnapp = 1
  ElkDirection = 1
  currentScoreElk = 0
  movedElkCounter = 1
  elkCounter = 1
  startElkCastNumber = 30
  stopElkCastNumber = 35
  startElkSpeed = 3
  elkSpeed = startElkSpeed
  changeElkPictureSpeed = 3
  startElk = -30
  endElk = 675
  elkAlive = 1
  checkLock = 0
  elkLock = 0
  standCounter = 1
  ElkHitCast = 9
  ElkAtStart = 1
  ElkGameOver = 0
  totalAnimationTime = 12.0
  gravity = 11.0
  ballSpeed = 0.22
  curveLimit = 150
  curveFactor = 0.0007
  targetHeight = 140
  changeInstopX = 0
  ballALive = 0
  animationCounterStart = 0.10000000000000001
  animationCounter = animationCounterStart
  ballLoopCounter = 1
  startMouseH = the mouseH
  mouseMoved = 0
  newMouseH = 0
  ballCastNumber = 15
  startX = 0
  stopX = 0
  startY = 0
  stopY = 0
  velYstart = 0
  ballSize = 26
  ballBroke = 0
  splatRemoveTime = the timer
  rightCurveNr = 0
  leftCurveNr = 0
  currentScorePlayer = 0
  counterWalk = 1
  maxFindusRight = 500
  maxFindusLeft = 100
  findusStep = 4
  findusCounter = 1
  startFindusCastNumber = 141
  stopFindusCastNumber = 144
  AnimFindusCastStart = [141, 147, 152, 160]
  AnimFindusCastStop = [144, 161, 158, 163]
  FindusState = 1
  AnimFindusCounter = 1
  AntalAnimggr = 0
  elkSpriteNumber = 3
  ballSpriteNumber = 25
  findusSpriteNumber = 17
  set the loc of sprite findusSpriteNumber to point(240, 400)
  if numberOfPlayers = 2 then
    set the loc of sprite elkSpriteNumber to point(30, 140)
  else
    set the loc of sprite elkSpriteNumber to point(startElk, 140)
  end if
  set the loc of sprite findusSpriteNumber to point(300, 430)
  preLoad(member(201, "julaudio"))
  preLoad(member(202, "julaudio"))
  preLoad(member(203, "julaudio"))
  preLoad(member(226, "julaudio"))
  ADDSCORE("Reset")
  InitPoangTomte(3, 40, 190, 3)
  ShowPoangtomte(0)
  ShowSparaFigur(1, 1)
  LitenFigTimer = 0
  LitenFigAktiv = 0
end
