on createChainedObjects chainPos
  global gameObjectList, chainList
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
      next repeat
    end if
    if count(thisDataList) = 6 then
      chain = thisDataList[6]
      UNIcreateUniObject(ObjectNr, Motion, EPC, path, action, chain)
      next repeat
    end if
    if count(thisDataList) = 7 then
      chain = thisDataList[6]
      SS = thisDataList[7]
      UNIcreateUniObject(ObjectNr, Motion, EPC, path, action, chain, SS)
    end if
  end repeat
end
