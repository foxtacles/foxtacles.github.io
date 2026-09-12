on exitFrame
  set the visible of sprite 45 to 0
  set the visible of sprite 44 to 0
  set the visible of sprite 46 to 0
  set the visible of sprite 38 to 1
  set the visible of sprite 39 to 1
  set the visible of sprite 40 to 1
  if rollOver(48) then
    cursor([61, 62])
    repeat while rollOver(48)
      set the visible of sprite 48 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(48) then
            set the visible of sprite 48 to 1
            cursor([61, 62])
          else
            set the visible of sprite 48 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(48) then
          set the visible of sprite 48 to 0
          puppetTransition(10)
          go("vidare")
        end if
      end if
    end repeat
    set the visible of sprite 48 to 0
    updateStage()
  else
    if rollOver(49) then
      cursor([61, 62])
      repeat while rollOver(49)
        set the visible of sprite 49 to 1
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(49) then
              set the visible of sprite 49 to 1
              cursor([61, 62])
            else
              set the visible of sprite 49 to 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(49) then
            set the visible of sprite 49 to 0
            startTimer()
            borjaom()
            go("huvud")
            exit
          end if
        end if
      end repeat
      set the visible of sprite 49 to 0
      updateStage()
    else
      cursor(0)
    end if
  end if
  go(the frame)
end
