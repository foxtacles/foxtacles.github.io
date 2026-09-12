on exitFrame
  repeat while the volume of sound 2 > 0
    set the volume of sound 2 to the volume of sound 2 - 10
    Wait(6)
  end repeat
  puppetSound(0)
  sound stop 2
  unloadMember()
  cursor(4)
  go(1, "kalender")
end
