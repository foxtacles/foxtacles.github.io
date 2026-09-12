on exitFrame
  volym = the volume of sound 2
  repeat while the volume of sound 2 > 0
    volym = volym - 0.14999999999999999
    set the volume of sound 2 to integer(volym)
  end repeat
  cursor(4)
  puppetSound(0)
  sound stop 2
  unloadMember()
  go(1, "kalender")
end
