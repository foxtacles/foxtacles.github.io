on exitFrame
  global ove
  ove = 1
  sprite(23).visible = 0
  sprite(24).visible = 0
  sound stop 2
  volym = the volume of sound 2
  repeat while volym < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  set the volume of sound 1 to 255
  puppetTransition(9)
  puppetSound(1, "rim.aif")
  go("one")
end
