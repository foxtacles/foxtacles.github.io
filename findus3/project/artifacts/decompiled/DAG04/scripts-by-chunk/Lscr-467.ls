global honIntervall, tid, klubba, tupp, decDate

on exitFrame
  puppetTempo(40)
  tid = the ticks
  set the visible of sprite 3 to 0
  set the visible of sprite 4 to 0
  set the visible of sprite 5 to 0
  set the visible of sprite 10 to 0
  set the visible of sprite 11 to 0
  set the visible of sprite 59 to 0
  set the visible of sprite 60 to 0
  set the visible of sprite 61 to 0
  repeat with channel = 21 to 34
    set the visible of sprite channel to 0
  end repeat
  volym = the volume of sound 2
  repeat while the volume of sound 2 < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  puppetTransition(9)
  go("tupp")
end
