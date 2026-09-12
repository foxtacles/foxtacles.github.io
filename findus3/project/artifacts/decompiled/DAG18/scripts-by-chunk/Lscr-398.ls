global stanna

on mouseDown
  Knapp = 9
  repeat while the mouseDown
    if rollOver(Knapp) then
      set the castNum of sprite Knapp to the number of member "nickfram"
    else
      set the castNum of sprite Knapp to the number of member "framåt"
    end if
    updateStage()
  end repeat
  if not rollOver(Knapp) then
    exit
  end if
  go(#next)
end
