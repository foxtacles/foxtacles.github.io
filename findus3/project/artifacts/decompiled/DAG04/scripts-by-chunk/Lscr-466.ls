global tid, nu

on exitFrame
  global posH, posV
  puppetSprite(60, 1)
  unloadMember(member(20), 24)
  unloadMember(member(65))
  unloadMember(member(79), 83)
  if nu = 5 then
    nu = 0
    honTest()
  end if
  if the ticks > (tid + 60) then
    honTest()
  end if
  if rollOver(3) then
    cursor([15, 16])
    set the visible of sprite 60 to 0
    updateStage()
    repeat while rollOver(3)
      set the visible of sprite 3 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(3) then
            set the visible of sprite 3 to 1
            cursor([15, 16])
          else
            set the visible of sprite 3 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(3) then
          puppetTransition(10)
          go("vidare")
        end if
      end if
    end repeat
    set the visible of sprite 3 to 0
    updateStage()
  else
    if rollOver(4) then
      cursor([15, 16])
      set the visible of sprite 60 to 0
      updateStage()
      repeat while rollOver(4)
        set the visible of sprite 4 to 1
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(4) then
              set the visible of sprite 4 to 1
              cursor([15, 16])
            else
              set the visible of sprite 4 to 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(4) then
            set the visible of sprite 10 to 0
            go("start")
          end if
        end if
      end repeat
      set the visible of sprite 4 to 0
      updateStage()
    else
      if rollOver(1) then
        cursor(200)
        puppetSprite(60, 1)
        puppetSprite(61, 1)
        set the locH of sprite 60 to the mouseH
        set the locV of sprite 60 to the mouseV
        set the locH of sprite 61 to the locH of sprite 60
        set the locV of sprite 61 to the locV of sprite 60
        set the visible of sprite 60 to 1
        updateStage()
      else
        set the visible of sprite 60 to 0
        cursor(0)
      end if
    end if
  end if
  if the mouseDown then
    nu = random(5)
    posH = the mouseH
    posV = the mouseV
    set the memberNum of sprite 60 to the memberNum of sprite 60 + 1
    updateStage()
    snoboll()
    tid = the ticks
    repeat while the ticks < (tid + 20)
      klubbmus()
    end repeat
    set the memberNum of sprite 60 to the memberNum of sprite 60 - 1
    updateStage()
  end if
  updateStage()
  go(the frame)
end
