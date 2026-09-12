global decDate, klar

on exitFrame
  klar = 0
  sprite(35).visible = 0
  sprite(40).visible = 0
  sprite(41).visible = 0
  sprite(70).visible = 0
  volym = the volume of sound 2
  repeat while volym < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  puppetTransition(9)
  puppetSound("rim.aif")
  go("bygg")
end
