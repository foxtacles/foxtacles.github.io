on exitFrame
  global tresex, volt, grab, holl, fram, brant, liv, xtra, langd, Burk, orgtime, fart, speed, step, vant, Hopp, Poang, bonus, fall
  if ((the ticks - orgtime) / 60) <> field("tid") then
    put (the ticks - orgtime) / 60 into field "tid"
  end if
  langd = langd + fart
  set the constraint of sprite 13 to 28
  if fart > brant then
    fart = brant
  end if
  if fart < 0 then
    fart = 0
  end if
  if fart < brant then
    fart = fart + 0.05
  end if
  speed = fart * step
  puppetSprite(13, 1)
  if (grab = 1) and (Hopp > 0) then
    set the castNum of sprite 13 to 13
  end if
  if (holl + Hopp + fram) = 0 then
    set the castNum of sprite 13 to 1
  end if
  if Hopp = 1 then
    if grab > 0 then
      grab = 0
      tresex = 0
      puppetSprite(13, 1)
      set the castNum of sprite 13 to 9
      puppetSound("ramla" & random(3))
      updateStage()
      fall = 10
      put integer(field("liv") - 1) into field "liv"
      Poang = Poang / 3
      bonus = 1
    else
      set the castNum of sprite 13 to 1
      updateStage()
    end if
  end if
  repeat with n = 3 to 5
    if sprite n intersects 13 and (fart > 0.40000000000000002) and (Hopp = 0) and (fall = 0) then
      puppetSound("hopp" & random(3))
      Hopp = integer(30 - step)
      Poang = 0
    end if
  end repeat
  if Hopp > 0 then
    if (grab + tresex) = 0 then
      set the castNum of sprite 13 to 10
    end if
    if tresex > 0 then
      puppetSprite(13, 1)
      set the castNum of sprite 13 to 13 + tresex
      updateStage()
    end if
    if grab = 1 then
      Poang = Poang + 50
    end if
    if Hopp = 1 then
      put integer(field("poang") + Poang) into field "poang"
      bonus = 1
    end if
    Hopp = Hopp - 1
  end if
  repeat with n = 6 to 8
    if sprite n intersects 13 and (Hopp > 0) then
      bonus = bonus + 1
    end if
    if sprite n intersects 13 and ((Hopp + fall) < 2) and (fart > 0.40000000000000002) then
      puppetSound("ramla" & random(3))
      puppetSprite(13, 1)
      set the castNum of sprite 13 to 9
      updateStage()
      fall = 10
    end if
  end repeat
  if fall > 0 then
    fall = fall - 1
    fart = fall * 0.10000000000000001
    puppetSprite(13, 1)
    set the castNum of sprite 13 to 9
  end if
  puppetSprite(13, 1)
  set the locH of sprite 13 to the locH of sprite 13 + (speed * holl)
  repeat with n = 3 to 8
    puppetSprite(n, 1)
    set the locV of sprite n to the locV of sprite n - speed
    if the locV of sprite n < 60 then
      set the locV of sprite n to 400 + random(100)
      set the locH of sprite n to 120 + random(400)
      repeat with q = 3 to 12
        if sprite q intersects n then
          set the locH of sprite n to 120 + random(400)
        end if
      end repeat
    end if
  end repeat
  if langd > 800 then
    puppetSprite(13, 0)
    go("slut")
  end if
  mustest()
  go(the frame)
end

on keyDown
  global Hopp, grab, volt, holl, fart, fram
  if (the keyCode = 124) and (holl = 0) and (Hopp = 0) then
    puppetSound("svŠng")
    updateStage()
    fart = fart - 0.29999999999999999
    puppetSprite(13, 1)
    set the castNum of sprite 13 to 2
    holl = 1
  end if
  if (the keyCode = 123) and (holl = 0) and (Hopp = 0) then
    puppetSound("svŠng")
    updateStage()
    fart = fart - 0.29999999999999999
    puppetSprite(13, 1)
    set the castNum of sprite 13 to 3
    holl = -1
  end if
  if the keyCode = 125 then
    if Hopp > 0 then
      grab = 1
    else
      fart = fart + 2
      holl = 0
      puppetSprite(13, 1)
      set the castNum of sprite 13 to 7
      updateStage()
      fram = 1
    end if
  end if
end

on keyUp
  global fram, grab, Hopp, holl
  fram = 0
  grab = 0
  puppetSprite(13, 1)
  if Hopp < 1 then
    set the castNum of sprite 13 to 1
  end if
  holl = 0
end

on vanta tid
  if tid > 0 then
    stop = the ticks + tid
    repeat while stop <> the ticks
      nothing()
    end repeat
  end if
end
