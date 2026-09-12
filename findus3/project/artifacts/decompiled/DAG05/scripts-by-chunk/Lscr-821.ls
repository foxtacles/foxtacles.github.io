global gBorja, gKalender, flash

on knappar
  if rollOver(gKalender) then
    sprite(gKalender).visible = 1
    if the mouseDown and (flash = 0) then
      repeat while the mouseDown = 1
        updateStage()
      end repeat
      puppetTransition(10)
      puppetSound(1, 0)
      go("spelslut")
    end if
  else
    sprite(gKalender).visible = 0
  end if
  if rollOver(gBorja) then
    sprite(gBorja).visible = 1
    if the mouseDown and (flash = 0) then
      repeat while the mouseDown = 1
        updateStage()
      end repeat
      puppetSound(1, 0)
      sprite(gBorja).visible = 0
      updateStage()
      go("spielen")
    end if
  else
    sprite(gBorja).visible = 0
  end if
end
