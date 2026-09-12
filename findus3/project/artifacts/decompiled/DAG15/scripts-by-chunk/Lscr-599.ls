on exitFrame
  volym = the volume of sound 2
  repeat while the volume of sound 2 > 0
    volym = volym - 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  puppetSound(0)
  sound stop 1
  sound stop 2
  unloadMember()
  cursor(4)
  go(1, "kalender")
end
