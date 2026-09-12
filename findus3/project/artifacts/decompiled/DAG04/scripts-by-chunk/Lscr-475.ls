global posH, posV

on snoboll
  boll = 59
  puppetSprite(boll, 1)
  set the locH of sprite boll to 320
  set the locV of sprite boll to 424
  set the height of sprite boll to 27
  set the width of sprite boll to 27
  set the visible of sprite boll to 1
  intervallH = (320 - posH) / 12
  intervallV = (424 - posV) / 12
  repeat with ove = 1 to 12
    set the height of sprite boll to the height of sprite boll - 1
    set the width of sprite boll to the width of sprite boll - 1
    set the locH of sprite boll to the locH of sprite boll - intervallH
    set the locV of sprite boll to the locV of sprite boll - intervallV
    updateStage()
    broms()
    klubbmus()
  end repeat
  set the visible of sprite boll to 0
  updateStage()
end
