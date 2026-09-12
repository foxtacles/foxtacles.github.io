on exitFrame
  set the visible of sprite 17 to rollOver(17)
  set the visible of sprite 18 to rollOver(18)
  if rollOver(17) or rollOver(18) or rollOver(32) or rollOver(33) then
    cursor([81, 82])
  else
    cursor(0)
  end if
  go(the frame)
end
