on exitFrame
  global hona
  hona = 0
  set the visible of sprite 52 to 1
  volym = the volume of sound 2
  repeat while the volume of sound 2 < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  puppetSound(1, "intro.aif")
  puppetTransition(9)
  go("go")
end
