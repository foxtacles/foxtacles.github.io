on updateGameObjects
  global gameObjectList, UNIObjectList, brothersTimer, numberOfBrothers, brothersPosListFree, brothersPosListActive, brothersPosList, brothersFree, brothersActive
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
        if (tObj.aktiv = 0) and (Nr > 2) and (Nr < 8) and ((tObj.aktivAction = 3) or (tObj.aktivAction = 6) or (tObj.aktivAction = 7)) then
          numberOfBrothers = numberOfBrothers - 1
          L = tObj.aktivAction
          ArrNr = getPos(brothersActive, Nr)
          if ArrNr = 0 then
            return 
          end if
          deleteAt(brothersTimer, ArrNr)
          deleteOne(brothersActive, Nr)
          add(brothersFree, Nr)
          repeat with j = 1 to count(brothersPosListActive)
            theData = brothersPosListActive[j]
            theBrother = theData[3]
            if theBrother = Nr then
              deleteAt(brothersPosListActive, j)
              add(brothersPosListFree, theData[1])
              exit repeat
            end if
          end repeat
          if (tObj.aktivAction = 6) or (tObj.aktivAction = 7) then
            tObj.posX = -1000
            tObj.posY = -1000
          end if
        end if
        if AktCastmember = 0 then
          AktCastmember = the memberNum of sprite tObj.SpriteNr
        end if
        SpNr = tObj.SpriteNr
        sprite(SpNr).loc = point(tObj.posX, tObj.posY)
        CastName = tObj.CastName
        set the member of sprite SpNr to member(AktCastmember, CastName)
      end if
      if soundsToPlay[i] <> EMPTY then
        PlaySound(soundsToPlay[i], 0)
      end if
    end repeat
  end if
  if chainedObjects <> [] then
    createChainedObjects(chainedObjects)
  end if
end
