on mustest
  if rollOver(30) then
    cursor([81, 82])
    set the visible of sprite 30 to 1
    updateStage()
    if the mouseDown then
      repeat while the mouseDown
        if rollOver(30) then
          set the visible of sprite 30 to 1
          cursor([81, 82])
        else
          set the visible of sprite 30 to 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(30) then
        set the visible of sprite 30 to 0
        puppetTransition(10)
        go("vidare")
      end if
    end if
    set the visible of sprite 31 to 0
    updateStage()
  else
    if rollOver(31) then
      cursor([81, 82])
      set the visible of sprite 31 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(31) then
            set the visible of sprite 31 to 1
            cursor([81, 82])
          else
            set the visible of sprite 31 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(31) then
          set the visible of sprite 31 to 0
          sound stop 2
          go("startt")
          repeat with n = 3 to 10
            puppetSprite(n, 0)
          end repeat
          exit
        end if
      end if
      set the visible of sprite 30 to 0
      updateStage()
    else
      set the visible of sprite 30 to 0
      set the visible of sprite 31 to 0
      cursor(0)
    end if
  end if
end
