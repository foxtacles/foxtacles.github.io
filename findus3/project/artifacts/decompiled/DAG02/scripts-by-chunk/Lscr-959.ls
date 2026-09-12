on exitFrame
  sound stop 2
  set the volume of sound 1 to 255
  sprite(12).locH = -9000
  updateStage()
  if not soundBusy(1) then
    puppetSound(1, "fisk" & random(2))
    ove = 1
  end if
  repeat while soundBusy(1)
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
          go("vidare")
          exit
        end if
      end if
      sprite(24).visible = 0
      updateStage()
      next repeat
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
          go("startframe")
          exit
        end if
      end if
      sprite(23).visible = 0
      updateStage()
      next repeat
    end if
    sprite(23).visible = 0
    sprite(24).visible = 0
    cursor(0)
  end repeat
  if ove = 1 then
    go("one")
  else
    go(the frame)
  end if
end
