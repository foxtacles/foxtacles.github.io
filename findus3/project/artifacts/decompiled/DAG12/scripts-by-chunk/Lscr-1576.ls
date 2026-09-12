on exitFrame
  global gameStage
  case gameStage of
    1:
      gameStage1()
    2:
      gameStage2()
    3:
      gameStage3()
    4:
      gameStage4()
    5:
      gameStage5()
    6:
      gameStage6()
    7:
      gameStage7()
    8:
      gameStage8()
    9:
      gameStage9()
    10:
      gameStage10()
    11:
      gameStage11()
    12:
      gameStage12()
    13:
      gameStage13()
    otherwise:
      Wait()
  end case
  updateGameObjects()
  checkDragging(the mouseLoc)
  go(the frame)
end
