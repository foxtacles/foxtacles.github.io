on playSnowboard
  global mark, liv, Hopp, fall, xtra, langd, orgtime, Burk, step, vant, holl
  holl = 0
  Burk = 1
  if Burk = 1 then
    step = 15
    vant = 0
  end if
  if Burk = 2 then
    step = 10
    vant = 2
  end if
  if Burk = 3 then
    step = 5
    vant = 2
  end if
  orgtime = the ticks
  langd = 0
  set the visible of sprite 17 to 0
  set the visible of sprite 18 to 0
  xtra = 10000
  liv = 3
  put "0" into field "tot"
  put "0" into field "poang"
  fall = "0"
  Hopp = "0"
  go(the frame + 1)
  put "0" into field "poang"
  tid = the ticks + 60
  updateStage()
  repeat while tid > the ticks
    nothing()
  end repeat
  unloadMember()
end
