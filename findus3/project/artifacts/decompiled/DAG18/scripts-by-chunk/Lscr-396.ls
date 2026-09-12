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
          puppetSound(0)
          puppetSound(2, 0)
          go("vidare")
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
            sound stop 1
            sprite(8).visible = 0
            sprite(14).visible = 1
            sprite(24).visible = 0
            go("ett")
            exit
          end if
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
