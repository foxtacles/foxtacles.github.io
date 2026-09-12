on KorLjudVantaMus Kanal, Ljud
  puppetSound(Kanal, Ljud)
  KnappTryckt = 0
  repeat while the mouseDown = 1
  end repeat
  repeat while soundBusy(Kanal) and (KnappTryckt = 0)
    if the mouseDown = 1 then
      KnappTryckt = 1
    end if
  end repeat
  puppetSound(Kanal, 0)
end

on KorLjudOchVanta Kanal, Ljud
  puppetSound(Kanal, Ljud)
  KnappTryckt = 0
  repeat while soundBusy(Kanal)
    nothing()
  end repeat
  repeat while the mouseDown = 1
  end repeat
end
