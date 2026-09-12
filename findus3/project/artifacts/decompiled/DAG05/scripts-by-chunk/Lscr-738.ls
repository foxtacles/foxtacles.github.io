global G_AktSparaFigur, InitVoice, AutoTimer, Poang

on FixaRedovisning
  global cCursorKanal
  cursor(-1)
  set the loc of sprite cCursorKanal to point(-1000, -1000)
  updateStage()
  repeat while soundBusy(2) = 1
  end repeat
  findusprat(2)
  repeat while soundBusy(2) = 1
  end repeat
  endGame()
end

on endGame
  ShowPoangtomte(1)
  case Poang of
    0, 1, 2:
      KorLjudOchVanta(1, "F208")
    3, 4, 5, 6:
      L = random(2)
      if L = 1 then
        KorLjudOchVanta(1, "F203")
      end if
      if L = 2 then
        KorLjudOchVanta(1, "F205ny")
      end if
    7, 8, 9, 10:
      L = random(2)
      if L = 1 then
        KorLjudOchVanta(1, "F204")
      end if
      if L = 2 then
        KorLjudOchVanta(1, "F206")
      end if
    otherwise:
      KorLjudOchVanta(1, "F207")
  end case
  init()
end
