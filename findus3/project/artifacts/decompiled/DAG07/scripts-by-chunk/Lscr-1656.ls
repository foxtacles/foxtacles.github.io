global decDate, klar, LinCast, LinusFirstTime

on exitFrame
  LinusFirstTime = 1
  LinCast = 120 + ((random(5) - 1) * 10)
  LinCast = 160
  repeat with i = 1 to 9
    sprite(13 + i - 1).member = member(LinCast + i - 1)
  end repeat
  klar = 0
  sprite(22).visible = 0
  sprite(23).visible = 0
  volym = the volume of sound 2
  repeat while volym < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  repeat with Kanal = 13 to 21
    set the moveableSprite of sprite Kanal to 0
  end repeat
  puppetTransition(9)
  go("hona")
end
