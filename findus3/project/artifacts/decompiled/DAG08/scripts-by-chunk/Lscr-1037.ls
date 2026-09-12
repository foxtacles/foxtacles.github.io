on TaBortDammDjur
  global HittSpriteNr
  repeat while soundBusy(2) = 1
  end repeat
  repeat with i = 1 to 3
    puppetSound(1, "Chip")
    set the loc of sprite (HittSpriteNr + i - 1) to point(-1000, -1000)
    updateStage()
    tt = the timer + 20
    repeat while the timer < tt
    end repeat
  end repeat
  tt = the timer + 60
  repeat while the timer < tt
  end repeat
  set the loc of sprite 30 to point(320, 240)
  set the loc of sprite 31 to point(-1000, -1000)
  updateStage()
  findusprat(7)
end
