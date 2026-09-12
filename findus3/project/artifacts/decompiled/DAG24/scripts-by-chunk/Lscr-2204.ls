on inittomte
  global tomtesprite, skosprites, huvudsprites, Ljudsprites, kladsprites, startpos, tomtepos, tomtearea, startsprites, endsprites, TomteSprites
  startsprites = [41, 42, 48, 66, 70]
  endsprites = [41, 47, 65, 69, 80]
  huvud = 0
  kropp = 0
  skor = 0
  Ljud = 0
  TomteSprites = [0, 0, 0, 0]
  tomtepos = [57, point(-8, 39), 42, point(-3, -59), 70, point(-15, -7), 59, point(-6, 49), 62, point(-5, 59), 68, point(-1000, -1000), 71, point(-14, -4), 48, point(-10, 48), 61, point(-4, 53), 63, point(-8, 70), 64, point(-10, 57), 67, point(-1000, -1000), 66, point(-1000, -1000), 65, point(-4, 58), 51, point(-12, 48), 80, point(-14, -11), 49, point(-15, 63), 54, point(-11, 78), 79, point(-9, -12), 55, point(-17, 54), 50, point(-9, 57), 78, point(-12, 0), 52, point(-9, 51), 69, point(-1000, -1000), 77, point(-13, -9), 45, point(-13, -55), 76, point(-23, -10), 58, point(-8, 49), 56, point(-6, 53), 75, point(-12, -1), 60, point(-6, 48), 53, point(-9, 53), 44, point(-6, -60), 72, point(-11, -12), 73, point(-16, -10), 47, point(-1, -58), 74, point(-15, 1), 43, point(-14, -53), 46, point(-16, -54)]
  UrspPos = point(324, 251)
  set the loc of sprite startsprites[1] to UrspPos
  updateStage()
  startpos = []
  tomtesprite = startsprites[1]
  r = rect(0, 100, 0, 0)
  tomtearea = sprite(tomtesprite).rect - r
  skosprites = []
  startpos = [42, point(366, 381), 43, point(299, 376), 44, point(-100, -1000), 45, point(438, 377), 46, point(241, 384), 47, point(172, 384), 48, point(400, 103), 49, point(260, 138), 50, point(358, 102), 51, point(257, 97), 52, point(306, 96), 53, point(500, 158), 54, point(155, 83), 55, point(401, 208), 56, point(207, 141), 57, point(252, 210), 58, point(416, 149), 59, point(154, 145), 60, point(363, 144), 61, point(306, 140), 62, point(461, 134), 63, point(491, 99), 64, point(451, 101), 65, point(201, 97), 66, point(274, 333), 67, point(315, 333), 68, point(358, 334), 69, point(400, 334), 70, point(532, 314), 71, point(198, 317), 72, point(110, 216), 73, point(160, 319), 74, point(492, 312), 75, point(529, 219), 76, point(489, 217), 77, point(452, 311), 78, point(154, 212), 79, point(189, 216), 80, point(117, 328)]
  StartVar = 1
  repeat with n = startsprites[2] to endsprites[2]
    append(skosprites, n)
    sprite(n).loc = startpos[getOne(startpos, n) + 1]
    StartVar = StartVar + 1
  end repeat
  huvudsprites = []
  repeat with n = startsprites[3] to endsprites[3]
    append(huvudsprites, n)
    sprite(n).loc = startpos[getOne(startpos, n) + 1]
    StartVar = StartVar + 1
  end repeat
  Ljudsprites = []
  repeat with n = startsprites[4] to endsprites[4]
    append(Ljudsprites, n)
    sprite(n).loc = startpos[getOne(startpos, n) + 1]
    StartVar = StartVar + 1
  end repeat
  kladsprites = []
  repeat with n = startsprites[5] to endsprites[5]
    append(kladsprites, n)
    sprite(n).loc = startpos[getOne(startpos, n) + 1]
    StartVar = StartVar + 1
  end repeat
  puppetSound(1, "P715ny")
end
