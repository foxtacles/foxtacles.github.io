on updateGameObjects_EXAMPLE
  global gameObjectList, UNIObjectList
  if UNIObjectList = [] then
    return 
  end if
  UNIreturn = []
  UNIreturn = UNIcheckActiveObjects()
  soundsToPlay = UNIreturn[1]
  deleteAt(UNIreturn, 1)
  chainedObjects = UNIreturn[1]
  deleteAt(UNIreturn, 1)
  if count(UNIreturn) > 0 then
    updatedObjects = []
    Antal = count(UNIreturn)
    repeat with i = 1 to Antal
      Smatris = UNIreturn[i]
      if Smatris <> [] then
        Nr = Smatris[1]
        add(updatedObjects, Nr)
        tObj = gameObjectList[Nr]
        tObj.posX = Smatris[2]
        tObj.posY = Smatris[3]
        AktCastmember = Smatris[4]
        tObj.AktBild = AktCastmember
        tObj.aktiv = Smatris[5]
        if AktCastmember = 0 then
          AktCastmember = the memberNum of sprite tObj.SpriteNr
        end if
        SpNr = tObj.SpriteNr
        sprite(SpNr).loc = point(tObj.posX, tObj.posY)
        CastName = tObj.CastName
        set the member of sprite SpNr to member(AktCastmember, CastName)
      end if
    end repeat
    soundEngine(soundsToPlay, updatedObjects)
    if chainedObjects <> [] then
      createChainedObjects(chainedObjects)
    end if
  end if
end
