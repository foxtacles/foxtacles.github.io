on mouseDown
  global liv, Hopp, fall, xtra, brant
  puppetSprite(5, 0)
  xtra = 10000
  liv = 3
  put "0" into field "tot"
  put "0" into field "poang"
  fall = "0"
  Hopp = "0"
  repeat with n = 1 to 20
    puppetSprite(the clickOn, 1)
    set the width of sprite the clickOn to the width of sprite the clickOn + 10
    set the height of sprite the clickOn to the height of sprite the clickOn + 10
    updateStage()
  end repeat
  puppetSprite(the clickOn, 0)
  brant = 25 - (the clickOn * 3)
  go(13 - the clickOn)
  put liv into field "liv"
end
