on exitFrame
  if rollOver(22) then
    repeat while rollOver(22)
      sprite(22).visible = 1
      cursor([33, 36])
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(22) then
            sprite(22).visible = 1
            cursor([33, 36])
          else
            sprite(22).visible = 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(22) then
          cursor(4)
          puppetTransition(10)
          puppetSound(0)
          puppetSound(2, 0)
          go("vidare")
        end if
      end if
    end repeat
    sprite(22).visible = 0
    cursor(0)
    updateStage()
  else
    if rollOver(23) then
      repeat while rollOver(23)
        sprite(23).visible = 1
        cursor([33, 36])
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(23) then
              sprite(23).visible = 1
              cursor([33, 36])
            else
              sprite(23).visible = 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(23) then
            omstart()
            exit
          end if
        end if
      end repeat
      sprite(23).visible = 0
      cursor(0)
      updateStage()
    else
      cursor(0)
    end if
  end if
  go(the frame)
end
