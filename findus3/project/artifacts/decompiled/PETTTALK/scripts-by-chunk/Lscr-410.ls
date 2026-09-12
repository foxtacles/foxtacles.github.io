on exitFrame
  global flash, FirstTime, gkalenderintro, AktRitning
  if gkalenderintro = 1 then
    go("spielen")
  else
    gkalenderintro = 1
    sprite(54).blend = 100
    flash = 0
    FirstTime = 1
    AktRitning = 1
    set the volume of sound 2 to 255
    puppetTransition(9)
    puppetSound(1, "rim")
  end if
end
