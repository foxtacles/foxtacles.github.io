on gameStage9
  global gameStage
  set the loc of sprite 42 to point(500, 200)
  updateStage()
  UNIcreateUniObject(12, 6, 1, [point(500, 220)], 1, [], 1)
  gameStage = gameStage + 0.5
end
