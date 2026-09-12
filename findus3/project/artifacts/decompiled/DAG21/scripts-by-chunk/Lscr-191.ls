global gGameTime

on exitFrame
  t = the timer / 60
  if t <> gGameTime then
    gGameTime = t
    s = gGameTime mod 60
    m = gGameTime / 60
    if s < 10 then
      s = "0" & s
    end if
    put m & ":" & s into field "time_field"
  end if
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
  if rollOver(8) or rollOver(9) or (rollOver(10) and (the memberNum of sprite 10 > 0)) or (rollOver(11) and (the memberNum of sprite 11 > 0)) or (rollOver(12) and (the memberNum of sprite 12 > 0)) or (rollOver(13) and (the memberNum of sprite 13 > 0)) or (rollOver(14) and (the memberNum of sprite 14 > 0)) or (rollOver(15) and (the memberNum of sprite 15 > 0)) or (rollOver(16) and (the memberNum of sprite 16 > 0)) or (rollOver(17) and (the memberNum of sprite 17 > 0)) or (rollOver(18) and (the memberNum of sprite 18 > 0)) then
    cursor([98, 99])
  else
    cursor(0)
  end if
  go(the frame)
end
