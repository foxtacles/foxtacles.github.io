on exitFrame
  puppetSound(1, "sark" & random(3))
  tupp = 45
  puppetSprite(tupp, 1)
  sprite(tupp).visible = 1
  repeat while soundBusy(1)
    set the memberNum of sprite tupp to member("hona" & random(3)).memberNum
    updateStage()
    tid = the ticks
    repeat while the ticks < (tid + 8)
      checkButt()
    end repeat
    checkButt()
  end repeat
  puppetSound(1, "rim.aif")
  puppetSprite(tupp, 0)
end

on checkButt
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
          go("vidare")
          abort()
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
            puppetSound(0)
            sprite(45).visible = 0
            omstart()
            abort()
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
end
