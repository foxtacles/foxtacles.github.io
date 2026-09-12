global gFarg

on mouseUp
  gFarg = the clickOn - 25 + 1
  if (gFarg > 4) or (gFarg < 0) then
    gFarg = 0
  end if
end
