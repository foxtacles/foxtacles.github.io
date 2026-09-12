global decDate

on exitFrame
  set the visible of sprite 11 to 1
  volym = the volume of sound 2
  repeat while volym < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  puppetSound("rim")
  puppetTransition(9)
  go("start")
end
