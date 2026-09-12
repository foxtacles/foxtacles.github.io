on checkForHit spriteNumber
  global gameObjectList
  repeat with i = 3 to 7
    tObj = gameObjectList[i]
    if tObj.aktiv = 1 then
      if sprite spriteNumber intersects tObj.SpriteNr then
        processHit(i, spriteNumber)
      end if
    end if
  end repeat
end

on processHit Objnr, rockSprite
  global gameObjectList, UNIObjectList, numberOfBrothers, brothersPosList, AntalPoang
  tObj = gameObjectList[Objnr]
  if tObj.aktivAction = 3 then
    return 
  end if
  posX = tObj.posX - 20
  posY = tObj.posY - 6
  listSize = count(UNIObjectList)
  case rockSprite of
    20:
      repeat with j = 1 to listSize
        theObjNr = UNIObjectList[j].UNIobjectNr
        if theObjNr = 2 then
          deleteAt(UNIObjectList, j)
          gameObjectList[2].aktiv = 0
          set the loc of sprite rockSprite to point(-1000, -1000)
          exit repeat
        end if
      end repeat
    21:
      repeat with j = 1 to listSize
        theObjNr = UNIObjectList[j].UNIobjectNr
        if theObjNr = 8 then
          deleteAt(UNIObjectList, j)
          gameObjectList[8].aktiv = 0
          set the loc of sprite rockSprite to point(-1000, -1000)
          exit repeat
        end if
      end repeat
  end case
  flyPath = [point(posX, posY), point(posX - (posX + 70), posY - 150)]
  UNIcreateUniObject(Objnr, 1, 1, flyPath, 3)
  AntalPoang = AntalPoang + (Objnr - 2)
  ShowPoangLillTomte(AntalPoang)
  case Objnr of
    3:
      PlaySound("b102", 1)
    4:
      PlaySound("b202", 1)
    5:
      PlaySound("b302", 1)
    6:
      PlaySound("b502", 1)
    7:
      PlaySound("b402", 1)
  end case
end
