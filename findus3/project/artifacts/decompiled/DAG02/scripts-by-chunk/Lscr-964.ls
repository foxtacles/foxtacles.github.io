on exitFrame
  global dx, dy
  nyPosLina()
  ritaLina(dx, dy)
  kollaPannan()
  kollaKanten()
  svischljud()
  if rollOver(23) then
    cursor([55, 56])
    sprite(23).visible = 1
    sprite(24).visible = 0
    updateStage()
    if the mouseDown then
      repeat while the mouseDown
      end repeat
      nyPosLina()
      ritaLina(dx, dy)
      kollaPannan()
      kollaKanten()
      svischljud()
      if rollOver(23) then
        sprite(23).visible = 1
        cursor([55, 56])
      else
        sprite(23).visible = 0
        cursor(0)
      end if
      updateStage()
      if rollOver(23) then
        sprite(23).visible = 0
        puppetSprite(6, 0)
        puppetSprite(7, 0)
        puppetSprite(8, 0)
        puppetSprite(9, 0)
        puppetSprite(10, 0)
        puppetSprite(11, 0)
        puppetSprite(12, 0)
        puppetTransition(10)
        go("vidare")
      end if
    end if
  else
    if rollOver(24) then
      cursor([55, 56])
      sprite(23).visible = 0
      sprite(24).visible = 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
        end repeat
        nyPosLina()
        ritaLina(dx, dy)
        kollaPannan()
        kollaKanten()
        svischljud()
        if rollOver(24) then
          sprite(24).visible = 1
          cursor([55, 56])
        else
          sprite(24).visible = 0
          cursor(0)
        end if
        updateStage()
        if rollOver(24) then
          sprite(24).visible = 0
          puppetSprite(9, 0)
          puppetSprite(10, 0)
          puppetSprite(11, 0)
          go("startframe")
        end if
      end if
    else
      cursor(0)
      sprite(23).visible = 0
      sprite(24).visible = 0
    end if
  end if
  go(the frame)
end
