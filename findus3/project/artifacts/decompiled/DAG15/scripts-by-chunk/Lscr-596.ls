on exitFrame
  set the visible of sprite 40 to 0
  set the visible of sprite 41 to 0
  set the visible of sprite 42 to 0
  volym = the volume of sound 2
  repeat while the volume of sound 2 < 130
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  puppetSound("rim.aif")
  puppetTransition(9)
  go(the frame + 1)
end
