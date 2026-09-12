global findusStep, maxFindusRight, maxFindusLeft, startFindusCastNumber, stopFindusCastNumber, changePictureSpeed, findusCounter, mouseIsDown, findusSpriteNumber, gameObjectList, UNIObjectList, chainList, numberOfBrothers, maxBrothers, brothersPosListFree, brothersPosListActive, brothersPosList, brothersFree, brothersActive, brothersTimer, clockTime, nextClockChange, gameStage, oldTimer, LatestBrotherTime, AntalPoang, FindusNr, BrothersSenasteCast, SpeletSlut, SpeletBorjat, FigTitt

on initvar
  findusSpriteNumber = 15
  FindusNr = 4
  brothersPosList = [[point(159, 95)], [point(114, 158), point(197, 166)], [point(107, 207), point(171, 205), point(224, 239)], [point(62, 283), point(131, 269), point(220, 248), point(167, 224)], [point(248, 287), point(158, 315), point(108, 299), point(157, 262)]]
  numberOfBrothers = 0
  maxBrothers = 4
  SpeletBorjat = 1
  gameObjectList = []
  UNIObjectList = []
  brothersPosListFree = [1, 2, 3, 4, 5]
  brothersPosListActive = []
  brothersFree = [3, 4, 5, 6, 7]
  brothersActive = []
  BrothersSenasteCast = [0, 0, 0, 0, 0]
  oldTimer = the timer
  slingPos = [point(490, 296)]
  stonePath1 = UNImoveInParabol(20, 0.5, 480, 300, -34, 20)
  stonePath2 = UNImoveInParabol(21, 0.5, 480, 300, -34, 90)
  stonePath3 = UNImoveInParabol(22, 0.59999999999999998, 480, 300, -34, 160)
  stonePath5 = UNImoveInParabol(23, 0.67000000000000004, 480, 300, -34, 230)
  stonePath6 = UNImoveInParabol(24, 0.69999999999999996, 480, 300, -34, 300)
  stonePath7 = UNImoveInParabol(25, 0.69999999999999996, 480, 300, -34, 370)
  chainList = [[2, 4, 1, stonePath1, 1], [2, 4, 1, stonePath2, 1], [2, 4, 1, stonePath3, 1], [2, 4, 1, stonePath3, 1], [2, 4, 1, stonePath5, 1], [2, 4, 1, stonePath6, 1], [2, 4, 1, stonePath7, 1], [1, 6, 1, slingPos, 8], [1, 6, 1, slingPos, 9], [1, 6, 1, slingPos, 10], [1, 6, 1, slingPos, 11], [1, 6, 1, slingPos, 12], [1, 6, 1, slingPos, 13], [1, 6, 1, slingPos, 14], [3, 6, -1, [], 2], [4, 6, -1, [], 2], [5, 6, -1, [], 2], [6, 6, -1, [], 2], [7, 6, -1, [], 2], [3, 6, -1, [], 5], [4, 6, -1, [], 5], [5, 6, -1, [], 5], [6, 6, -1, [], 5], [7, 6, -1, [], 5], [8, 4, 1, stonePath1, 1], [8, 4, 1, stonePath2, 1], [8, 4, 1, stonePath3, 1], [8, 4, 1, stonePath3, 1], [8, 4, 1, stonePath5, 1], [8, 4, 1, stonePath6, 1], [8, 4, 1, stonePath7, 1]]
  mouseIsDown = 0
  changePictureSpeed = 2
  findusCounter = 1
  startFindusCastNumber = 33
  stopFindusCastNumber = 36
  maxFindusRight = 580 + 18
  maxFindusLeft = 550
  findusStep = 7
  createGameObjectList()
  InitPoangTomte(5, 60, 261, 3, 1)
  ShowPoangtomte(1)
  InitPoangLillTomte(10, 301, 3)
  ShowPoangLillTomte(0)
  ShowSparaFigur(1, 1)
  PreloadSounds()
  InitVarInnanSpel()
end

on InitVarInnanSpel
  BrothersSenasteCast = [0, 0, 0, 0, 0]
  oldTimer = the timer
  gameStage = 1
  brothersTimer = []
  clockTime = 120
  nextClockChange = the timer
  LatestBrotherTime = 999
  AntalPoang = 0
  brothersPosListFree = [1, 2, 3, 4, 5]
  brothersPosListActive = []
  brothersFree = [3, 4, 5, 6, 7]
  brothersActive = []
  repeat with i = 1 to 5
    sprite(30 + i - 1).loc = point(-1000, -1000)
  end repeat
  SpeletSlut = 0
  FigTitt = 0
end
