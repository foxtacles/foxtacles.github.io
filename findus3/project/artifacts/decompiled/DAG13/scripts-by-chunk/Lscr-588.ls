on exitFrame
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
          repeat while the mouseDown
            if rollOver(24) then
              sprite(24).visible = 1
              cursor([98, 99])
            else
              sprite(24).visible = 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(24) then
            sprite(24).visible = 0
            go("ovn4.1")
            exit repeat
          end if
        end if
      end repeat
      sprite(24).visible = 0
      updateStage()
    else
      if rollOver(3) or rollOver(4) or rollOver(5) or rollOver(6) or rollOver(7) or rollOver(8) or rollOver(9) or rollOver(10) or rollOver(23) or rollOver(24) or rollOver(26) or rollOver(27) or rollOver(28) or rollOver(29) or rollOver(30) or rollOver(31) or rollOver(32) or rollOver(33) then
        cursor([98, 99])
      else
        cursor(0)
      end if
    end if
  end if
  go(the frame)
end
