on klubbmus
  if rollOver(1) then
    cursor(200)
    set the locH of sprite 60 to the mouseH
    set the locV of sprite 60 to the mouseV
    set the visible of sprite 60 to 1
    updateStage()
  else
    cursor(0)
    set the visible of sprite 60 to 0
    updateStage()
  end if
end
