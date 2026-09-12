on exitFrame
  global u, s, dra, vatt, gravety, rakna, plock
  u = u + 0.10000000000000001
  set the locH of sprite 30 to the locH of sprite 3 + 30
  set the locV of sprite 30 to the locV of sprite 3 + 50
  if sprite 3 intersects 21 then
    set the castNum of sprite 30 to 100
    puppetSound("collide3")
    updateStage()
    tid(100)
    slut()
  end if
  if sprite 3 intersects sprite(4) then
    u = u * -1
    set the locV of sprite 3 to the locV of sprite 4 + 20
  end if
  if sprite 3 intersects sprite(5) then
    puppetSound("bounce08")
    s = (the locH of sprite 3 + (the width of sprite 3 / 2) - the locH of sprite 5) / 5
    u = -7
    plock = 1
  end if
  if sprite 3 intersects sprite(7) then
    s = abs(s) * -1
  end if
  if sprite 3 intersects sprite(6) then
    s = abs(s)
  end if
  repeat with n = 22 to 23
    if sprite n intersects 3 and (the castNum of sprite n <> 51) and (the castNum of sprite n <> 53) then
      puppetSound("bird.aif")
      puppetSprite(n, 1)
      plock = 0
      set the castNum of sprite n to the castNum of sprite n + 1
    end if
  end repeat
  if plock = 1 then
    repeat with n = 8 to 20
      if sprite n intersects 3 and (the visible of sprite n = 1) then
        puppetSound("bra" & random(3))
        rakna = rakna + 1
        set the visible of sprite n to 0
        plock = 0
      end if
    end repeat
  end if
  if rakna > 11 then
    repeat with n = 1 to 100
      puppetSprite(n, 0)
    end repeat
    go("bra")
  end if
  if u > 0 then
    if s > 0 then
      set the castNum of sprite 30 to 111
    end if
    if s < 0 then
      set the castNum of sprite 30 to 110
    end if
    if s = 0 then
      set the castNum of sprite 30 to 109
    end if
  end if
  if u < 0 then
    if s > 0 then
      set the castNum of sprite 30 to 105
    end if
    if s < 0 then
      set the castNum of sprite 30 to 104
    end if
    if s = 0 then
      set the castNum of sprite 30 to 75
    end if
  end if
  if (the rect of sprite 3).bottom > 300 then
    set the castNum of sprite 30 to 101
  end if
  set the locV of sprite 3 to the locV of sprite 3 + u
  set the locH of sprite 3 to the locH of sprite 3 + s
  set the locH of sprite 5 to the mouseH
  if the mouseV > 390 then
    cursor(0)
  else
    cursor(200)
  end if
  mustest()
  go(the frame)
end
