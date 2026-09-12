global lucka, decDate, k, ord

on exitFrame
  k = the key
  ord = EMPTY
  checkDate()
  lucka = 0
  sprite(3).visible = 0
  sprite(4).visible = 0
  sprite(5).visible = 0
  sprite(6).visible = 0
  sprite(11).visible = 0
  sprite(15).visible = 0
  sprite(16).visible = 0
  sprite(48).visible = 0
  repeat with channel = 51 to 74
    sprite(channel).visible = 0
  end repeat
  puppetSprite(50, 1)
  set the memberNum of sprite 50 to member(decDate, "dagar")
  volym = the volume of sound 2
  repeat while the volume of sound 2 < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  set the volume of sound 2 to 100
  set the volume of sound 1 to 255
  puppetTransition(9)
  go(5)
end
