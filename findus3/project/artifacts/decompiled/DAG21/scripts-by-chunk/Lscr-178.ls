on exitFrame
  if rollOver(8) then
    set the visible of sprite 8 to 1
    repeat while the mouseDown
      if rollOver(8) then
        set the visible of sprite 8 to 1
        cursor([98, 99])
      else
        set the visible of sprite 8 to 0
        cursor(0)
      end if
      updateStage()
    end repeat
  else
    set the visible of sprite 8 to 0
  end if
  if rollOver(9) then
    set the visible of sprite 9 to 1
    repeat while the mouseDown
      if rollOver(9) then
        set the visible of sprite 9 to 1
        cursor([98, 99])
      else
        set the visible of sprite 9 to 0
        cursor(0)
      end if
      updateStage()
    end repeat
  else
    set the visible of sprite 9 to 0
  end if
  if rollOver(8) or rollOver(9) then
    cursor([98, 99])
  else
    cursor(0)
  end if
  go(the frame)
end
