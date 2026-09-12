on exitFrame
  global FindusTimer
  if the timer > FindusTimer then
    go(the frame + 1)
  else
    go(the frame)
  end if
end
