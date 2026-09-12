on exitFrame
  global mark
  set the visible of sprite 17 to 0
  set the visible of sprite 18 to 0
  set the visible of sprite 30 to 0
  set the visible of sprite 31 to 0
  volym = the volume of sound 2
  repeat while volym < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  mark = 1
  puppetSound(1, "rim.aif")
  puppetTransition(9)
  go(the frame + 1)
end
