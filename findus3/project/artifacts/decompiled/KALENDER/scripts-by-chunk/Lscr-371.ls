global open

on stanglucka
  puppetSprite(15, 1)
  puppetSprite(16, 1)
  repeat while the memberNum of sprite 15 > 71
    set the memberNum of sprite 15 to the memberNum of sprite 15 - 1
    updateStage()
    Wait(8)
  end repeat
  sprite(15).visible = 0
  sprite(16).visible = 0
  open = 0
  updateStage()
  puppetSprite(15, 0)
  puppetSprite(16, 0)
end
