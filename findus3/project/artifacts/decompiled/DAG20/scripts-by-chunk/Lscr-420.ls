global decDate

on exitFrame
  set the visible of sprite 22 to 0
  set the visible of sprite 23 to 0
  volym = the volume of sound 2
  repeat while the volume of sound 2 < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  puppetTransition(9)
  go("hona")
end
