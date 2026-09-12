global gBorja, gKalender, OkAttAvsluta

on knappar
  if rollOver(gKalender) then
    sprite(gKalender).visible = 1
    if the mouseDown then
      puppetTransition(10)
      puppetSound(1, 0)
      go("SlutSpel")
    end if
  else
    sprite(gKalender).visible = 0
  end if
  if rollOver(gBorja) and (OkAttAvsluta = 1) then
    sprite(gBorja).visible = 1
    if the mouseDown then
      go(3)
      puppetSound(1, 0)
      sprite(gBorja).visible = 0
    end if
  else
    sprite(gBorja).visible = 0
  end if
end
