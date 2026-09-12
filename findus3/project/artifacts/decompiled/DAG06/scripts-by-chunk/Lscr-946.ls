on exitFrame
  if rollOver(30) then
    cursor([81, 82])
    repeat while rollOver(30)
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
    end repeat
    set the visible of sprite 30 to 0
    updateStage()
  else
    if rollOver(31) then
      cursor([81, 82])
      repeat while rollOver(31)
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
            updateStage()
            sound stop 2
            playSnowboard()
            exit
          end if
        end if
      end repeat
      set the visible of sprite 31 to 0
      updateStage()
    else
      cursor(0)
    end if
  end if
  go(the frame)
end
