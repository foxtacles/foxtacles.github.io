global gPath, gPathLen, gPathPos, gPathDist, gNumObjects, gOldX, gOldY, gLastTicks, gSoundCount

on exitFrame
  gOldX = the mouseH
  gOldY = the mouseV
  gPathLen = 1000
  gPath = list()
  x0 = the locH of sprite 10
  y0 = the locV of sprite 10
  repeat with i = 1 to gPathLen
    X = integer((sin(2.0 * 3.14150000000000018 * i / 100) * 150.0) + x0)
    Y = integer((cos(2.0 * 3.14150000000000018 * i / 100) * 50.0) + y0)
    add(gPath, point(X, Y))
  end repeat
  gPathPos = 1
  gPathDist = 10
  gNumObjects = 5
  createObjects()
  repeat with i = 10 to 15
    set the visible of sprite i to 1
  end repeat
  set the visible of sprite 5 to 0
  gLastTicks = the timer
  gSoundCount = random(9)
  puppetSound("borja_ljud")
  unloadMember()
  go("gameloop")
end
