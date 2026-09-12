on startMovie
  global s, u, fart, liv
  put 0 into field "p"
  set the constraint of sprite 3 to 1
  fart = 3
  s = 1
  u = -1
  repeat with n = 26 to 28
    set the visible of sprite n to 1
  end repeat
  liv = 3
end

on slut
  global rakna, s, u, liv
  liv = liv - 1
  if liv = 2 then
    set the visible of sprite 26 to 0
  end if
  if liv = 1 then
    set the visible of sprite 27 to 0
  end if
  updateStage()
  s = 0
  u = 0
  set the locH of sprite 3 to 320
  set the locV of sprite 3 to 170
  set the locH of sprite 30 to the locH of sprite 3 + 30
  set the locV of sprite 30 to the locV of sprite 3 + 50
  set the castNum of sprite 30 to 75
  if liv = 0 then
    repeat with n = 1 to 100
      puppetSprite(n, 0)
    end repeat
    go("slut")
  end if
  updateStage()
  tid(50)
end

on tid n
  tid = the ticks + n
  repeat while tid > the ticks
    set the locH of sprite 5 to the mouseH
    updateStage()
  end repeat
end
