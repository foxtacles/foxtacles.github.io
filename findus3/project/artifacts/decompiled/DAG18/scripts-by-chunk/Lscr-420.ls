global stanna, s

on mustest
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
          go("vidare")
          abort()
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
            sprite(8).visible = 0
            sprite(14).visible = 1
            sprite(24).visible = 0
            sound stop 2
            stanna = 1
            go("ett")
            abort()
          end if
        end if
      end repeat
      sprite(24).visible = 0
      updateStage()
    else
      if rollOver(7) or rollOver(9) then
        cursor([98, 99])
        if the mouseDown then
          cursor(0)
          stanna = 1
          set the volume of sound 2 to 0
          sound stop 2
          puppetSound(0)
          s = 4
          exit
        end if
      else
        cursor(0)
      end if
    end if
  end if
end
