on exitFrame
  puppetSound(1, "sark" & random(3))
  tupp = 45
  puppetSprite(tupp, 1)
  set the visible of sprite tupp to 1
  repeat while soundBusy(1)
    set the memberNum of sprite tupp to member("hona" & random(3)).memberNum
    updateStage()
    tid = the ticks
    repeat while the ticks < (tid + 8)
      rollKnapp()
      if the mouseDown then
        set the visible of sprite 52 to 0
        puppetSound(0)
        set the visible of sprite tupp to 0
        puppetSprite(tupp, 0)
        exit repeat
      end if
    end repeat
    rollKnapp()
  end repeat
  puppetSound(1, "rim.aif")
  puppetSprite(tupp, 0)
  go("start")
end

on rollKnapp
  if rollOver(3) then
    cursor([15, 16])
    set the visible of sprite 60 to 0
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
        puppetSound(0)
        puppetTransition(10)
        go("vidare")
        abort()
      end if
    end if
    set the visible of sprite 4 to 0
    updateStage()
  else
    if rollOver(4) then
      cursor([15, 16])
      set the visible of sprite 60 to 0
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
        set the visible of sprite 4 to 0
        if rollOver(4) then
          puppetSound(0)
          go(4)
          abort()
        end if
      end if
      set the visible of sprite 3 to 0
      updateStage()
    else
      set the visible of sprite 3 to 0
      set the visible of sprite 4 to 0
      cursor(0)
    end if
  end if
end
