global plats

on eggkast
  boll = 59
  puppetSprite(boll, 1)
  set the visible of sprite 60 to 0
  case plats of
    1:
      set the loc of sprite boll to point(526, 231)
    2:
      set the loc of sprite boll to point(467, 311)
    3:
      set the loc of sprite boll to point(467, 311)
    4:
      set the loc of sprite boll to point(367, 345)
    5:
      set the loc of sprite boll to point(326, 323)
    6:
      set the loc of sprite boll to point(215, 344)
    7:
      set the loc of sprite boll to point(189, 320)
    8:
      set the loc of sprite boll to point(63, 210)
    9:
      set the loc of sprite boll to point(57, 89)
    10:
      set the loc of sprite boll to point(158, 158)
    11:
      set the loc of sprite boll to point(306, 138)
    12:
      set the loc of sprite boll to point(494, 112)
    13:
      set the loc of sprite boll to point(590, 113)
  end case
  posH = the locH of sprite boll
  posV = the locV of sprite boll
  intervallH = (320 - posH) / 12
  intervallV = (240 - posV) / 12
  set the height of sprite boll to 15
  set the width of sprite boll to 15
  set the visible of sprite boll to 1
  updateStage()
  repeat with ove = 1 to 12
    set the height of sprite boll to the height of sprite boll + 4
    set the width of sprite boll to the width of sprite boll + 4
    set the locH of sprite boll to the locH of sprite boll + intervallH
    set the locV of sprite boll to the locV of sprite boll + intervallV
    updateStage()
    broms()
    klubbmus()
  end repeat
  set the visible of sprite boll to 0
  set the visible of sprite 11 to 1
  updateStage()
  puppetSound("hit.aif")
  ur = the ticks
  repeat while the ticks < (ur + 20)
    klubbmus()
  end repeat
  set the visible of sprite 11 to 0
  updateStage()
end
