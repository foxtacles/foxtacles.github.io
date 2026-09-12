on checkMouse rock1, rock2
  global mouseIsDown
  if (mouseIsDown = 0) and (the mouseDown = 1) then
    fireSling(rock1, rock2)
    mouseIsDown = 1
  else
    if (mouseIsDown = 1) and (the mouseDown = 1) then
      nothing()
    else
      if (mouseIsDown = 1) and (the mouseDown = 0) then
        mouseIsDown = 0
      end if
    end if
  end if
end

on fireSling rock1, rock2
  global FindusNr
  num = FindusNr + 1
  if (rock1 = 0) and (rock2 = 0) then
    rock = random(2)
  else
    if (rock1 = 1) and (rock2 = 0) then
      rock = 2
    else
      if (rock1 = 0) and (rock2 = 1) then
        rock = 1
      end if
    end if
  end if
  case rock of
    1:
      UNIcreateUniObject(1, 6, 1, [the loc of sprite 4], num, [num, num + 7], 1)
    2:
      UNIcreateUniObject(1, 6, 1, [the loc of sprite 4], num, [num + 24, num + 7], 1)
  end case
end
