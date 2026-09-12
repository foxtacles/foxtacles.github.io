global currentScorePlayer, G_AktSparaFigur, currentScoreElk, numberOfPlayers

on checkClock
  global clockTime, nextClockChange
  if the timer >= nextClockChange then
    clockTime = clockTime - 1
    fixClock(clockTime)
    nextClockChange = the timer + 60
  end if
end

on fixClock newTime
  global ElkGameOver
  if newTime > 100 then
    N1 = 1
    newTime = newTime - 100
    n3 = newTime mod 10
    n2 = (newTime - n3) / 10
  else
    if newTime = 100 then
      N1 = 1
      n2 = 0
      n3 = 0
    else
      N1 = 0
      n3 = newTime mod 10
      n2 = (newTime - n3) / 10
    end if
  end if
  set the memberNum of sprite 26 to 92 + N1
  set the memberNum of sprite 27 to 92 + n2
  set the memberNum of sprite 28 to 92 + n3
  if (N1 = 0) and (n2 = 0) and (n3 = 0) then
    ElkGameOver = 1
  end if
end

on endGame
  RensaLjud()
  puppetSound(1, "Dong")
  repeat while soundBusy(1)
  end repeat
  if numberOfPlayers = 1 then
    if currentScorePlayer > currentScoreElk then
      L = random(5)
      if L = 1 then
        KorLjudOchVanta(1, "F314")
      end if
      if L = 2 then
        KorLjudOchVanta(1, "F315")
      end if
      if L = 3 then
        KorLjudOchVanta(1, "F317")
      end if
      if L = 4 then
        KorLjudOchVanta(1, "F318")
      end if
      if L = 5 then
        KorLjudOchVanta(1, "F319")
      end if
    else
      L = random(2)
      if L = 1 then
        KorLjudOchVanta(1, "F307ny")
      end if
      if L = 2 then
        KorLjudOchVanta(1, "F308ny")
      end if
    end if
    ShowPoangtomte(0)
  end if
  if numberOfPlayers = 2 then
    if currentScorePlayer > currentScoreElk then
      KorLjudOchVanta(1, "F316")
    else
      L = random(2)
      if L = 1 then
        KorLjudOchVanta(1, "F308")
      end if
      if L = 2 then
        KorLjudOchVanta(1, "F313")
      end if
    end if
  end if
  initvar()
end
