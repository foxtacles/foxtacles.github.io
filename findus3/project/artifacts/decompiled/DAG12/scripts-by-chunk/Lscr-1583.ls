on Wait
  global UNIObjectList, gameStage, holdStage
  if soundBusy(1) or soundBusy(2) or (count(UNIObjectList) > 0) or (holdStage = 1) then
    return 
  else
    gameStage = integer(gameStage + 0.5)
  end if
end
