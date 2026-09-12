on exitFrame
  global gKnappen, hona
  unloadMember(member(43), 54)
  unloadMember(member(63))
  if rollOver(40) then
    cursor([30, 31])
    repeat while rollOver(40)
      sprite(40).visible = 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(40) then
            sprite(40).visible = 1
            cursor([30, 31])
          else
            sprite(40).visible = 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(40) then
          sprite(40).visible = 0
          puppetTransition(10)
          Avslutafilmen = 1
        end if
      end if
    end repeat
    sprite(40).visible = 0
    updateStage()
  else
    if rollOver(41) then
      cursor([30, 31])
      repeat while rollOver(41)
        sprite(41).visible = 1
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(41) then
              sprite(41).visible = 1
              cursor([30, 31])
            else
              sprite(41).visible = 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(41) then
            sprite(41).visible = 0
            puppetSprite(10, 0)
            cursor(200)
            sprite(52).visible = 1
            gKnappen = 1
            sound stop 1
            go("startgame")
            exit
          end if
        end if
      end repeat
      sprite(41).visible = 0
      updateStage()
    else
      cursor(0)
    end if
  end if
  if not soundBusy(1) and (hona = 1) then
    puppetSound(1, "snark.aif")
  else
    if not soundBusy(1) and (hona = 0) then
      go("tupp")
    end if
  end if
  if Avslutafilmen = 1 then
    puppetSound(0)
    puppetSound(2, 0)
    go("vidare")
  end if
  go(the frame)
end
