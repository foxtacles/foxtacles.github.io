on airDrop
  global gameStage, oldTimer
  if the timer >= oldTimer then
    oldTimer = the timer + 6
    set the locV of sprite 40 to the locV of sprite 40 + 10
    set the memberNum of sprite 40 to the memberNum of sprite 40 + 1
    if the memberNum of sprite 40 = 236 then
      set the memberNum of sprite 40 to 232
    end if
    if the locV of sprite 40 >= 550 then
      gameStage = 2
    end if
  end if
end
