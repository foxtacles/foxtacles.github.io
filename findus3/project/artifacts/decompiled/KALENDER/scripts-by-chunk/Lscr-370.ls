global open, pos, dag

on openlucka
  puppetSprite(15, 1)
  puppetSprite(16, 1)
  set the memberNum of sprite 16 to cast(dag, "dagar").memberNum
  set the loc of sprite 16 to pos
  set the loc of sprite 15 to pos
  sprite(15).visible = 1
  open = 1
  updateStage()
  sprite(16).visible = 1
  repeat while the memberNum of sprite 15 < 74
    set the memberNum of sprite 15 to the memberNum of sprite 15 + 1
    updateStage()
    Wait(6)
  end repeat
end
