on mouseDown
  Knapp = 7
  repeat while the mouseDown
    if rollOver(Knapp) then
      set the castNum of sprite Knapp to the number of member "nickbak"
    else
      set the castNum of sprite Knapp to the number of member "bakåt"
    end if
    updateStage()
  end repeat
  if not rollOver(Knapp) then
    exit
  end if
  go("fem")
end
