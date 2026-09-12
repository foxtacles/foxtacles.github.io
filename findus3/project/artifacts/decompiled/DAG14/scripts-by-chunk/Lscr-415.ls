on exitFrame
  if rollOver(40) then
    repeat while rollOver(40)
      sprite(40).visible = 1
      cursor([33, 36])
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(40) then
            sprite(40).visible = 1
            cursor([33, 36])
          else
            sprite(40).visible = 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(40) then
          repeat with k = 21 to 64
            puppetSprite(k, 1)
          end repeat
          cursor(4)
          puppetTransition(10)
          go("vidare")
        end if
      end if
    end repeat
    sprite(40).visible = 0
    cursor(0)
    updateStage()
  else
    if rollOver(41) then
      repeat while rollOver(41)
        sprite(41).visible = 1
        cursor([33, 36])
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(41) then
              sprite(41).visible = 1
              cursor([33, 36])
            else
              sprite(41).visible = 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(41) then
            omstart()
          end if
        end if
      end repeat
      sprite(41).visible = 0
      cursor(0)
      updateStage()
    else
      cursor(0)
    end if
  end if
  go(the frame)
end
