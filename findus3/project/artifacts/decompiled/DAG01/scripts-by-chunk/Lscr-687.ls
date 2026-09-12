on exitFrame
  cursor(4)
  sound stop 1
  puppetSound(0)
  volym = the volume of sound 2
  repeat while the volume of sound 2 > 0
    volym = volym - 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  sound stop 2
  unloadMember(member(55))
  go(1, "kalender")
end
