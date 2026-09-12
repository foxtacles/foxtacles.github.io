on gameStage1
  global gameStage, FirstTime
  UNIcreateUniObject(5, 6, 1, [point(320, 480)], 2)
  UNIcreateUniObject(3, 4, 5, [point(390, 170), point(377, 163), point(365, 164), point(340, 163), point(338, 186), point(354, 193), point(377, 191), point(390, 185), point(395, 178)], 1, [6], 1)
  gameStage = gameStage + 0.5
  if FirstTime = 1 then
    FirstTime = 0
    puppetSound(2, "F601")
  else
    puppetSound(2, "F601b")
  end if
end
