on exitFrame
  if the volume of sound 2 > 127 then
    set the volume of sound 2 to 127
  end if
  if rollOver(23) then
    cursor([98, 99])
    repeat while rollOver(23)
      sprite(23).visible = 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(23) then
            sprite(23).visible = 1
            cursor([98, 99])
          else
            sprite(23).visible = 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(23) then
          sprite(23).visible = 0
          puppetTransition(10)
          puppetSound(0)
          puppetSound(2, 0)
          go("kalender")
        end if
      end if
    end repeat
    sprite(23).visible = 0
    updateStage()
  else
    if rollOver(24) then
      cursor([98, 99])
      repeat while rollOver(24)
        sprite(24).visible = 1
        updateStage()
        if the mouseDown then
          sprite(24).visible = 0
          go("ovn4.1")
          exit repeat
        end if
      end repeat
      sprite(24).visible = 0
      updateStage()
    else
      cursor(0)
    end if
  end if
  go(the frame)
end
