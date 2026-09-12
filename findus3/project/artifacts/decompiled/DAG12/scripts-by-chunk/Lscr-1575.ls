on initvar
  global OkAttAvsluta, gameObjectList, UNIObjectList, gameStage, chainList, soundObjectActive, spriteBeingDragged, holdStage, dragSpritePosList, spriteInBowl, ingredientList, G_soundList, G_soundObjects, G_soundActive1, G_soundActive2, FirstTime, G_AktGame
  G_AktGame = 6
  FirstTime = 1
  G_soundList = []
  G_soundObjects = []
  G_soundActive1 = 0
  G_soundActive2 = 0
  ingredientList = []
  spriteInBowl = 0
  dragSpritePosList = [point(112, 150), point(330, 100), point(550, 145), point(112, 150), point(550, 145)]
  holdStage = 0
  gameObjectList = []
  UNIObjectList = []
  soundObjectActive = 0
  spriteBeingDragged = 0
  spoonList = [point(390, 170), point(377, 163), point(365, 164), point(340, 163), point(338, 186), point(354, 193), point(377, 191), point(390, 185), point(395, 178)]
  eggList = UNImoveInParabol(24, 1.19999999999999996, -50, 340, 270, 340)
  chainList = [[2, 6, 1, [point(230, 187)], 1, [2, 8], 1], [1, 1, 1, [point(130, 170), point(-120, 170)], 1], [4, 6, 1, [point(442, 215)], 1, [4, 8], 1], [6, 1, 1, [point(500, 175), point(710, 175)], 1], [8, 6, 1, [point(270, 280)], 1, [8], 1], [1, 1, 1, [point(-120, 170), point(130, 170)], 1, [1]], [6, 1, 1, [point(710, 175), point(500, 175)], 1, [3], 1], [3, 4, 5, spoonList, 1, [], 1], [7, 4, 1, eggList, 1, [5], 1], [9, 1, 1, [point(314, 237), point(314, 142), point(914, 142)], 2, [], 1], [10, 1, 1, [point(445, 260), point(445, 165), point(1045, 165)], 2], [11, 1, 1, [point(110, 170), point(110, 75), point(710, 75)], 2]]
  gameStage = 0.5
  createGameObjectList()
  From = 9
  preloadMember(member(9, "graphics"), member(14, "graphics"))
  OkAttAvsluta = 0
  sprite(70).loc = point(306, 453)
end
