global decDate, spelDag, dag

on exitFrame
  spel = the mouseCast
  Hopp = 0
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
          sprite(3).visible = 0
          go("avsluta")
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
            Hopp = 1
            exit repeat
          end if
        end if
      end repeat
      cursor(0)
      sprite(4).visible = 0
      updateStage()
    else
      if (spel > 131131) and (spel <= (131131 + decDate)) then
        cursor([33, 36])
        spelDag = spel - 131131
        aktivSpel = spelDag + 50
        puppetSprite(11, 1)
        set the locH of sprite 11 to the locH of sprite (spelDag + 50) + 123
        set the locV of sprite 11 to the locV of sprite (spelDag + 50) + 7
        set the width of sprite 11 to 250
        sprite(11).visible = 1
        updateStage()
        repeat while rollOver(spelDag + 50)
          if the mouseDown then
            repeat while the mouseDown
              if rollOver(spelDag + 50) then
                cursor([33, 36])
                sprite(11).visible = 1
                updateStage()
                next repeat
              end if
              cursor(0)
              sprite(11).visible = 0
              updateStage()
            end repeat
            if rollOver(spelDag + 50) then
              sprite(11).visible = 1
              puppetSprite(11, 0)
              if spelDag < 10 then
                dag = "dag0" & spelDag
                Hopp = 2
                exit repeat
                next repeat
              end if
              dag = "dag" & spelDag
              Hopp = 2
              exit repeat
            end if
          end if
        end repeat
        cursor(0)
        sprite(11).visible = 0
        updateStage()
      else
        cursor(0)
        sprite(11).visible = 0
        set the width of sprite 11 to 1
        updateStage()
      end if
    end if
  end if
  if Hopp = 1 then
    go(5)
  else
    if Hopp = 2 then
      puppetTransition(10)
      go("vidare")
    else
      go(the frame)
    end if
  end if
end
