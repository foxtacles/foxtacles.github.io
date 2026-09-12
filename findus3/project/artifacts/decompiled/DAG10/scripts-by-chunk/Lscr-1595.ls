on exitFrame
  global gameStage, clockTime, SpeletSlut
  case gameStage of
    1:
      gameStage = 2
    2:
      mainLoop()
    3:
    4:
  end case
  if (clockTime = 0) and (SpeletSlut = 0) then
    SpeletSlut = 1
  end if
  if SpeletSlut = 2 then
    endGame()
  end if
  go(the frame)
end
