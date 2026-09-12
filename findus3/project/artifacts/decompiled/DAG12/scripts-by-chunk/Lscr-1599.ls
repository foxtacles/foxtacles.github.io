on gameStage11
  global gameStage, ingredientList
  set the loc of sprite 42 to point(-1000, -1000)
  set the loc of sprite 43 to point(-1000, -1000)
  updateStage()
  a = ingredientList[1]
  b = ingredientList[2]
  surprise = 0
  case b of
    9:
      case a of
        6:
          surprise = 1
        7:
          surprise = 2
        8:
          surprise = 3
      end case
    10:
      case a of
        6:
          surprise = 4
        7:
          surprise = 5
        8:
          surprise = 6
      end case
  end case
  layOutSurprise(surprise)
  gameStage = gameStage + 0.5
end
