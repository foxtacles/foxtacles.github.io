global gBorja, gKalender

on knappar
  if rollOver(gKalender) then
    sprite(gKalender).visible = 1
    if the mouseDown then
      puppetTransition(10)
      puppetSound(1, 0)
      go("SpelSlut")
    end if
  else
    sprite(gKalender).visible = 0
  end if
  if rollOver(gBorja) then
    sprite(gBorja).visible = 1
    if the mouseDown then
      go(5)
      puppetSound(1, 0)
      puppetSound(2, 0)
      sprite(gBorja).visible = 0
    end if
  else
    sprite(gBorja).visible = 0
  end if
end
