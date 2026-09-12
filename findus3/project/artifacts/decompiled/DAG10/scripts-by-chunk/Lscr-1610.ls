global gameObjectList, UNIObjectList

on clearObject Nr
  deleteList = []
  if integerp(Nr) then
    Nr = [Nr]
  end if
  repeat with i = 1 to count(Nr)
    repeat with j = 1 to count(UNIObjectList)
      tUNIobj = UNIObjectList[j]
      if tUNIobj.UNIobjectNr = Nr[i] then
        add(deleteList, [Nr[i], j])
      end if
    end repeat
  end repeat
  theSize = count(deleteList)
  if theSize then
    sort(deleteList)
    repeat with k = theSize down to 1
      tObj = gameObjectList[deleteList[k][1]]
      deleteAt(UNIObjectList, deleteList[k][2])
      tObj.Active = 0
      tObj.activeAction = 0
      set the loc of sprite the SpriteNr of tObj to point(-1000, -1000)
    end repeat
  end if
end

on stopObject Nr
  deleteList = []
  if integerp(Nr) then
    Nr = [Nr]
  end if
  repeat with i = 1 to count(Nr)
    repeat with j = 1 to count(UNIObjectList)
      tUNIobj = UNIObjectList[j]
      if tUNIobj.UNIobjectNr = Nr[i] then
        add(deleteList, [Nr[i], j])
      end if
    end repeat
  end repeat
  theSize = count(deleteList)
  if theSize then
    sort(deleteList)
    repeat with k = theSize down to 1
      tObj = gameObjectList[deleteList[k][1]]
      deleteAt(UNIObjectList, deleteList[k][2])
      tObj.Active = 0
      tObj.activeAction = 0
    end repeat
  end if
end
