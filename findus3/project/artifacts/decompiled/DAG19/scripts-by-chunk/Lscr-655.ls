on exitFrame
  if rollOver(23) then
    cursor([98, 99])
    repeat while rollOver(23)
      set the visible of sprite 23 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(23) then
            set the visible of sprite 23 to 1
            cursor([98, 99])
          else
            set the visible of sprite 23 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(23) then
          set the visible of sprite 23 to 0
          go(1, "kalender")
        end if
      end if
    end repeat
    set the visible of sprite 23 to 0
    updateStage()
  else
    if rollOver(24) then
      cursor([98, 99])
      repeat while rollOver(24)
        set the visible of sprite 24 to 1
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(24) then
              set the visible of sprite 24 to 1
              cursor([98, 99])
            else
              set the visible of sprite 24 to 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(24) then
            set the visible of sprite 24 to 0
            go("INTRO")
          end if
        end if
      end repeat
      set the visible of sprite 24 to 0
      updateStage()
    else
      if rollOver(3) or rollOver(4) or rollOver(5) or rollOver(6) or rollOver(7) or rollOver(8) or rollOver(9) or rollOver(10) or rollOver(23) or rollOver(24) or rollOver(26) or rollOver(27) or rollOver(28) or rollOver(29) or rollOver(30) or rollOver(31) or rollOver(32) or rollOver(33) then
        cursor([98, 99])
      else
        cursor(0)
      end if
    end if
  end if
  go(the frame)
end
