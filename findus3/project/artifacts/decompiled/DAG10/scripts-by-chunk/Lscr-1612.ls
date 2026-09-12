on createGameObjectList
  global gameObjectList
  objects = 8
  gameObjectList = []
  repeat with i = 1 to objects
    add(gameObjectList, new(script("gameObject")))
  end repeat
  Nr = 1
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 4, 0, 1, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[22, 28, 29, 30, 31], [23, 28, 29, 30, 31], [24, 28, 29, 30, 31], [25, 28, 29, 30, 31], [26, 28, 29, 30, 31], [28, 29, 30, 31], [29, 30, 31], [32, 22], [32, 23], [32, 24], [32, 25], [32, 26], [32, 27], [32, 28]]
  tObj.FrameTime = [[1, 0, 0, 0, 0, 5], [1, 0, 0, 0, 0, 5], [1, 0, 0, 0, 0, 5], [1, 0, 0, 0, 0, 5], [1, 0, 0, 0, 0, 5], [1, 0, 0, 0, 5], [1, 0, 0, 5], [10, 1], [7, 2], [7, 2], [7, 2], [7, 2], [7, 2], [7, 2]]
  tObj.StartcastNr = [0]
  tObj.SlutcastNr = [0]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 29, "FJONG"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 2
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 20, 0, 1, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [52]
  tObj.FrameTime = [1]
  tObj.StartcastNr = [0]
  tObj.SlutcastNr = [0]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 3
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 30, 10, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[92, 93, 94, 95, 96, 97, 98], [98, 99, 97, 98, 99, 97], [], [137, 138, 139, 140, 141, 142, 143], [143, 144, 145, 143, 144, 145], [98, 97, 96, 95, 94, 93, 92], [143, 142, 141, 140, 139, 138, 137]]
  tObj.FrameTime = [1, 2, 2, 1, 2, 1, 1]
  tObj.StartcastNr = [0, 0, 190]
  tObj.SlutcastNr = [0, 0, 195]
  tObj.CastIntervall = [0, 0, 0]
  tObj.standSequens = [0, 0, 0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 92, "B101"], ["C", 137, "B101"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 4
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 31, 10, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[101, 102, 103, 104, 105, 106, 107], [108, 109, 108, 107], [], [146, 147, 148, 149, 150, 151, 152], [153, 154, 153, 152], [107, 106, 105, 104, 103, 102, 101], [152, 151, 150, 149, 148, 147, 146]]
  tObj.FrameTime = [1, 3, 2, 2, 3, 1, 1]
  tObj.StartcastNr = [0, 0, 197]
  tObj.SlutcastNr = [0, 0, 202]
  tObj.CastIntervall = [0, 0, 0]
  tObj.standSequens = [0, 0, 0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 101, "B201"], ["C", 146, "B201"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 5
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 32, 10, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[110, 111, 112, 113, 114, 115, 116], [117, 118, 117, 118, 117, 116], [], [155, 156, 157, 158, 159, 160, 161], [162, 163, 162, 163, 162, 161], [116, 115, 114, 113, 112, 111, 110], [161, 160, 159, 158, 157, 156, 155]]
  tObj.FrameTime = [1, 3, 2, 2, 3, 1, 1]
  tObj.StartcastNr = [0, 0, 211]
  tObj.SlutcastNr = [0, 0, 216]
  tObj.CastIntervall = [0, 0, 0]
  tObj.standSequens = [0, 0, 0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 110, "B301"], ["C", 155, "B301"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 6
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 33, 10, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[119, 120, 121, 122, 123, 124, 125], [126, 127, 126, 125], [], [164, 165, 166, 167, 168, 169, 170], [171, 172, 171, 170], [125, 124, 123, 122, 121, 120, 119], [170, 169, 168, 167, 166, 165, 164]]
  tObj.FrameTime = [1, 2, 2, 2, 2, 1, 1]
  tObj.StartcastNr = [0, 0, 204]
  tObj.SlutcastNr = [0, 0, 209]
  tObj.CastIntervall = [0, 0, 0]
  tObj.standSequens = [0, 0, 0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 119, "B501"], ["C", 164, "B501"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 7
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 34, 10, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[128, 129, 130, 131, 132, 133, 134], [135, 134, 135, 136, 135, 134, 135, 136, 135], [], [173, 174, 175, 176, 177, 178, 179], [180, 179, 180, 181, 180, 179, 180, 181, 180], [134, 133, 132, 131, 130, 129, 128], [179, 178, 177, 176, 175, 174, 173]]
  tObj.FrameTime = [1, 2, 2, 2, 2, 1, 1]
  tObj.StartcastNr = [0, 0, 218]
  tObj.SlutcastNr = [0, 0, 223]
  tObj.CastIntervall = [0, 0, 0]
  tObj.standSequens = [0, 0, 0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 128, "B401"], ["C", 173, "B401"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 8
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 21, 4, 1, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [52]
  tObj.FrameTime = [1]
  tObj.StartcastNr = [0]
  tObj.SlutcastNr = [0]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  initSveaObjectFlags(tObj, 0, 1, 0)
end
