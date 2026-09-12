global gAntalPynt, gPyntSprite, gFarg, gAllaFargade, gAllaFargadeCount

on exitFrame
  moveCursor(1)
  checkButtons()
  gPyntSprite = 10
  gAntalPynt = 13
  repeat with i = 1 to gAntalPynt
    puppetSprite(i + gPyntSprite - 1, 1)
  end repeat
  repeat with i = 25 to 28
    puppetSprite(i, 1)
  end repeat
  gFarg = 1
  gAllaFargade = 0
  gAllaFargadeCount = 0
  puppetSound("DAG22_P_INTRO" & random(2))
  unloadMember()
  go("mainloop")
end
