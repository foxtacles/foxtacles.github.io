global gFindus

on idle
end

on exitFrame
  global gKnappen, hona, findusprat
  hona = 1
  if not soundBusy(1) then
    if findusprat = 1 then
      puppetSprite(10, 0)
      set the visible of sprite 52 to 0
      unloadMember(member(33))
      unloadMember(member(45))
      go("meny")
    end if
  end if
  setturnangle(gFindus, 0)
  acc(gFindus, 0)
  move(gFindus)
  doLayers()
  musKnapp()
  if not soundBusy(1) and (findusprat = 0) then
    puppetSound(1, "rent.aif")
    findusprat = 1
  end if
  updateStage()
  go(the frame)
end

on musKnapp
  if rollOver(40) then
    cursor([30, 31])
    repeat while rollOver(40)
      if the shiftDown or the controlDown then
        exit repeat
      end if
      set the visible of sprite 40 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(40) then
            set the visible of sprite 40 to 1
            cursor([30, 31])
          else
            set the visible of sprite 40 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(40) then
          set the visible of sprite 40 to 0
          puppetTransition(10)
          go("vidare")
        end if
      end if
    end repeat
    set the visible of sprite 40 to 0
    updateStage()
  else
    if rollOver(41) then
      cursor([30, 31])
      repeat while rollOver(41)
        if the shiftDown or the controlDown then
          exit repeat
        end if
        set the visible of sprite 41 to 1
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(41) then
              set the visible of sprite 41 to 1
              cursor([30, 31])
            else
              set the visible of sprite 41 to 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(41) then
            set the visible of sprite 41 to 0
            puppetSprite(10, 0)
            put EMPTY into field "tid_field"
            set the visible of sprite 52 to 0
            go("startgame")
            exit
          end if
        end if
      end repeat
      set the visible of sprite 41 to 0
      updateStage()
    else
      cursor(0)
    end if
  end if
end
