on createGameObjectList
  global gameObjectList
  objects = 13
  gameObjectList = []
  repeat with i = 1 to objects
    add(gameObjectList, new(script("gameObject")))
  end repeat
  Nr = 1
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 15, 12, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 99, string("graphics"))
  tObj.Animation_bilder = [0]
  tObj.FrameTime = [1]
  tObj.StartcastNr = [99]
  tObj.SlutcastNr = [99]
  tObj.CastIntervall = [0]
  tObj.standSequens = [100]
  tObj.aktivAction = 0
  tObj.Talande = 0
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 2
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 16, 0, 1, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[101, 102, 103, 104, 105, 106, 107, 108, 109]]
  tObj.FrameTime = [[4, 2, 2, 2, 2, 2, 2, 2, 2]]
  tObj.StartcastNr = [0]
  tObj.SlutcastNr = [0]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 102, "BakaFX03"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 3
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 5, 0, 3, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[71, 72, 73, 74, 75, 76, 77, 78, 79]]
  tObj.FrameTime = [2]
  tObj.StartcastNr = [0]
  tObj.SlutcastNr = [0]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["P", 2, "nyBakaFX01"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 4
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 18, 0, 0, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[123, 124, 125, 126, 127, 128, 129, 130]]
  tObj.FrameTime = [[2, 2, 2, 2, 2, 2, 2, 2, 4]]
  tObj.StartcastNr = [0]
  tObj.SlutcastNr = [0]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 125, "BakaFX04"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 5
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 40, 0, 0, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[9, 10, 11, 12, 13, 14], [14, 13, 12, 11, 10, 9], [14, 13, 12, 11, 10, 9]]
  tObj.FrameTime = [[4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 4], [4, 4, 4, 4, 4, 160]]
  tObj.StartcastNr = [0, 0, 0]
  tObj.SlutcastNr = [0, 0, 0]
  tObj.CastIntervall = [0, 0, 0]
  tObj.standSequens = [0, 0, 0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 10, "F615"], ["C", 10, "F617"], ["C", 10, "F616"], ["C", 10, "F614"], ["C", 10, "F619"], ["C", 10, "F618"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 6
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 17, 12, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [0]
  tObj.FrameTime = [1]
  tObj.StartcastNr = [121]
  tObj.SlutcastNr = [121]
  tObj.CastIntervall = [0]
  tObj.standSequens = [122]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 121, "F606"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 7
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 11, 0, 1, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [85]
  tObj.FrameTime = [1]
  tObj.StartcastNr = [85]
  tObj.SlutcastNr = [85]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 85, "F607"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 8
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 20, 0, 0, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[86, 87, 88, 89]]
  tObj.FrameTime = [[2, 2, 2, 2]]
  tObj.StartcastNr = [0]
  tObj.SlutcastNr = [0]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 86, "BakaFX02"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 9
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 30, 8, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [40, 0]
  tObj.FrameTime = [120, 1]
  tObj.StartcastNr = [0, 40]
  tObj.SlutcastNr = [0, 40]
  tObj.CastIntervall = [0, 0]
  tObj.standSequens = [0, 0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["P", 1, "F618b"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 10
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 32, 8, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [62, 0]
  tObj.FrameTime = [120, 1]
  tObj.StartcastNr = [0, 62]
  tObj.SlutcastNr = [0, 62]
  tObj.CastIntervall = [0, 0]
  tObj.standSequens = [0, 0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 11
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 31, 8, 1, 1)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [70, 0]
  tObj.FrameTime = [120, 1]
  tObj.StartcastNr = [0, 69]
  tObj.SlutcastNr = [0, 69]
  tObj.CastIntervall = [0, 0]
  tObj.standSequens = [0, 0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 12
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 43, 0, 0, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163]]
  tObj.FrameTime = [[5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 35, 5, 5]]
  tObj.StartcastNr = [0]
  tObj.SlutcastNr = [0]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  tObj.soundSequens = [["C", 150, "TickTick"]]
  initSveaObjectFlags(tObj, 0, 1, 0)
  Nr = 13
  tObj = gameObjectList[Nr]
  initSveaObject(tObj, Nr, 34, 0, 0, 0)
  initSveaObjectPosition(tObj, 0, 0, 0, string("graphics"))
  tObj.Animation_bilder = [[28, 29, 30, 31, 32, 33]]
  tObj.FrameTime = [[40, 90, 8, 8, 8, 40]]
  tObj.StartcastNr = [0]
  tObj.SlutcastNr = [0]
  tObj.CastIntervall = [0]
  tObj.standSequens = [0]
  tObj.aktivAction = 0
  tObj.Talande = 0
  initSveaObjectFlags(tObj, 0, 1, 0)
end
