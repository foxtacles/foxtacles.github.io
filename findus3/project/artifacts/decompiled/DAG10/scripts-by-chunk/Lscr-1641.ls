on createChainedObjects_EXAMPLE chainPos
  global gameObjectList, G_OnScreenObjects, G_Talande, chainList
  repeat with i = 1 to count(chainPos)
    thisChainPos = chainPos[i]
    thisDataList = chainList[thisChainPos]
    ObjectNr = thisDataList[1]
    Motion = thisDataList[2]
    EPC = thisDataList[3]
    path = thisDataList[4]
    action = thisDataList[5]
    if count(thisDataList) = 5 then
      UNIcreateUniObject(ObjectNr, Motion, EPC, path, action)
    else
      if count(thisDataList) = 6 then
        chain = thisDataList[6]
        UNIcreateUniObject(ObjectNr, Motion, EPC, path, action, chain)
      else
        if count(thisDataList) = 7 then
          chain = thisDataList[6]
          SS = thisDataList[7]
          UNIcreateUniObject(ObjectNr, Motion, EPC, path, action, chain, SS)
        end if
      end if
    end if
    a = getOne(G_OnScreenObjects, ObjectNr)
    if a = 0 then
      add(G_OnScreenObjects, ObjectNr)
    end if
    b = getOne(G_Talande, ObjectNr)
    if b = 0 then
      add(G_Talande, ObjectNr)
    end if
  end repeat
end
