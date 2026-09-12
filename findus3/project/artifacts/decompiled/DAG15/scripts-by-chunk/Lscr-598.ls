on initHopp
  global s, u, fart, liv, rakna
  go("start")
  unloadMember()
  preloadMember(member(100), 111)
  rakna = 0
  repeat with n = 8 to 19
    set the visible of sprite n to 1
  end repeat
  set the constraint of sprite 3 to 1
  fart = 3
  s = 0
  u = 0
  u = -1
  puppetSprite(3, 1)
  puppetSprite(5, 1)
  set the locH of sprite 3 to 320
  set the locV of sprite 3 to 170
  repeat with n = 26 to 28
    set the visible of sprite n to 1
  end repeat
  liv = 3
  set the visible of sprite 42 to 1
  sound stop 1
  updateStage()
end
