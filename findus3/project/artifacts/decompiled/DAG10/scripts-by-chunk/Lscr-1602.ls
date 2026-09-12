on checkClock
  global clockTime, nextClockChange
  if the timer >= nextClockChange then
    clockTime = clockTime - 1
    fixClock(clockTime)
    nextClockChange = the timer + 60
  end if
end

on fixClock newTime
  if newTime > 100 then
    N1 = 1
    newTime = newTime - 100
    n3 = newTime mod 10
    n2 = (newTime - n3) / 10
  else
    if newTime = 100 then
      N1 = 1
      n2 = 0
      n3 = 0
    else
      N1 = 0
      n3 = newTime mod 10
      n2 = (newTime - n3) / 10
    end if
  end if
  set the memberNum of sprite 26 to 57 + N1
  set the memberNum of sprite 27 to 57 + n2
  set the memberNum of sprite 28 to 57 + n3
end
