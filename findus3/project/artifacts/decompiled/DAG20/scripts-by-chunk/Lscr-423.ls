on exitFrame
  if rollOver(22) then
    repeat while rollOver(22)
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
          go("vidare")
        end if
      end if
    end repeat
    set the visible of sprite 22 to 0
    cursor(0)
    updateStage()
  else
    if rollOver(23) then
      repeat while rollOver(23)
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
            omstart()
            exit repeat
          end if
        end if
      end repeat
      set the visible of sprite 23 to 0
      cursor(0)
      updateStage()
    else
      cursor(0)
    end if
  end if
  go(the frame)
end
