on exitFrame
  if rollOver(3) then
    cursor([33, 36])
    sprite(3).visible = 1
    updateStage()
    repeat while rollOver(3)
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(3) then
            cursor([33, 36])
            sprite(3).visible = 1
            updateStage()
            next repeat
          end if
          cursor(0)
          sprite(3).visible = 0
          updateStage()
        end repeat
        if rollOver(3) then
          puppetSprite(50, 0)
          go("credits")
        end if
      end if
    end repeat
    cursor(0)
    sprite(3).visible = 0
    updateStage()
  else
    if rollOver(4) then
      cursor([33, 36])
      sprite(4).visible = 1
      updateStage()
      repeat while rollOver(4)
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(4) then
              cursor([33, 36])
              sprite(4).visible = 1
              updateStage()
              next repeat
            end if
            cursor(0)
            sprite(4).visible = 0
            updateStage()
          end repeat
          if rollOver(4) then
            sprite(4).visible = 0
            go("kista")
          end if
        end if
      end repeat
      cursor(0)
      sprite(4).visible = 0
      updateStage()
    end if
  end if
  go(the frame)
end
