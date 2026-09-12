global gFarg

on moveCursor flagga
  knappFlagga = rollOver(5) or rollOver(6)
  if knappFlagga or flagga then
    if knappFlagga then
      cursor(list(133, 134))
    else
      cursor(-1)
    end if
    set the visible of sprite 31 to 0
  else
    cursor(200)
    set the memberNum of sprite 31 to 135 + gFarg
    set the loc of sprite 31 to point(the mouseH, the mouseV)
    set the visible of sprite 31 to 1
  end if
end

on checkButtons
  set the visible of sprite 5 to rollOver(5)
  set the visible of sprite 6 to rollOver(6)
end
