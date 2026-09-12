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
      musOve()
      if the mouseDown then
        puppetSound(0)
        set the visible of sprite tupp to 0
        puppetSprite(tupp, 0)
        go("start")
        exit repeat
      end if
    end repeat
    musOve()
  end repeat
  puppetSound(1, "rim.aif")
  puppetSprite(tupp, 0)
end

on musOve
  if rollOver(22) then
    set the visible of sprite 22 to 1
    cursor([33, 36])
    updateStage()
    if the mouseDown then
      repeat while the mouseDown
        if rollOver(22) then
          set the visible of sprite 22 to 1
          cursor([33, 36])
        else
          set the visible of sprite 22 to 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(22) then
        cursor(4)
        puppetTransition(10)
        puppetSound(0)
        set the visible of sprite 45 to 0
        go("vidare")
        abort()
      end if
    end if
    set the visible of sprite 23 to 0
    updateStage()
  else
    if rollOver(23) then
      set the visible of sprite 23 to 1
      cursor([33, 36])
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(23) then
            set the visible of sprite 23 to 1
            cursor([33, 36])
          else
            set the visible of sprite 23 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(23) then
          puppetSound(0)
          set the visible of sprite 45 to 0
          omstart()
          abort()
        end if
      end if
      set the visible of sprite 22 to 0
      updateStage()
    else
      set the visible of sprite 23 to 0
      set the visible of sprite 22 to 0
      cursor(0)
    end if
  end if
end
