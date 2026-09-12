on exitFrame
  tupp = 45
  puppetSprite(tupp, 1)
  set the visible of sprite tupp to 1
  repeat while soundBusy(1)
    set the memberNum of sprite tupp to member("hona" & random(3)).memberNum
    updateStage()
    tid = the ticks
    repeat while the ticks < (tid + 8)
      rollKnapp()
    end repeat
    rollKnapp()
  end repeat
  puppetSprite(tupp, 0)
  go("init")
end

on rollKnapp
  if rollOver(28) then
    cursor([18, 19])
    set the visible of sprite 28 to 1
    updateStage()
    if the mouseDown then
      repeat while the mouseDown
        if rollOver(28) then
          set the visible of sprite 28 to 1
          cursor([18, 19])
        else
          set the visible of sprite 28 to 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(28) then
        set the visible of sprite 45 to 0
        puppetSound(0)
        puppetTransition(10)
        go("exit")
        abort()
      end if
    end if
    set the visible of sprite 29 to 0
    updateStage()
  else
    if rollOver(29) then
      cursor([18, 19])
      set the visible of sprite 29 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(29) then
            set the visible of sprite 29 to 1
            cursor([18, 19])
          else
            set the visible of sprite 29 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(29) then
          set the visible of sprite 45 to 0
          puppetSound(0)
          go("init")
          abort()
        end if
      end if
      set the visible of sprite 28 to 0
      updateStage()
    else
      set the visible of sprite 28 to 0
      set the visible of sprite 29 to 0
      cursor(0)
    end if
  end if
end
