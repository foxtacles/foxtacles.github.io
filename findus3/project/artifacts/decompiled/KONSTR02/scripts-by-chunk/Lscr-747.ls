on Measuring
  global UseDelay
  exit
  UseDelay = 1
  set the locH of sprite 5 to -300
  startTimer()
  put the timer
  repeat with i = 1 to 100
    set the visible of sprite 5 to 0
    updateStage()
    set the visible of sprite 5 to 1
    updateStage()
  end repeat
  put the timer
  if the timer > 30 then
    UseDelay = 0
  end if
end
