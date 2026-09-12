on exitFrame
  global dag
  volym = the volume of sound 2
  repeat while the volume of sound 2 > 0
    volym = volym - 15
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  sound stop 2
  unloadMember()
  cursor(4)
  go(1, dag)
end
