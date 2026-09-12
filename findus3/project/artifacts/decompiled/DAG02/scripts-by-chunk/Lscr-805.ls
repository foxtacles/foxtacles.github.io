on exitFrame
  Hopp = 0
  if rollOver(23) then
    cursor([55, 56])
    sprite(23).visible = 1
    updateStage()
    if the mouseDown then
      repeat while the mouseDown
        if rollOver(23) then
          sprite(23).visible = 1
          cursor([55, 56])
        else
          sprite(23).visible = 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(23) then
        sprite(23).visible = 0
        puppetTransition(10)
        Hopp = 1
      end if
    end if
  else
    sprite(23).visible = 0
    updateStage()
  end if
  if rollOver(24) then
    cursor([55, 56])
    sprite(24).visible = 1
    updateStage()
    if the mouseDown then
      repeat while the mouseDown
        if rollOver(24) then
          sprite(24).visible = 1
          cursor([55, 56])
        else
          sprite(24).visible = 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(24) then
        puppetSound(0)
        sprite(24).visible = 0
        Hopp = 2
      end if
    end if
  else
    sprite(24).visible = 0
    updateStage()
  end if
  if (rollOver(24) = 0) and (rollOver(23) = 0) then
    cursor(0)
    updateStage()
  end if
  if Hopp > 0 then
    repeat while the mouseDown = 1
    end repeat
    if Hopp = 1 then
      puppetTransition(10)
      go("vidare")
    else
      if Hopp = 2 then
        go("startframe")
      end if
    end if
  else
    go(the frame)
  end if
end
