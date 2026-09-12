on UNIcheckSoundTriggers objUNINr
  global UNIObjectList, gameObjectList, tObj
  tObj = UNIObjectList[objUNINr]
  thisPath = tObj.UNIpathList
  thisPic = tObj.UNIaktPic
  thisReturn = EMPTY
  if tObj.UNIsoundTriggerP <> 0 then
    thisPoint = getPos(thisPath, point(tObj.UNIaktX, tObj.UNIaktY))
    if thisPoint = tObj.UNIsoundTriggerP then
      thisReturn = tObj.UNIsounds
      tObj.UNIsounds = EMPTY
      tObj.UNIsoundTriggerP = 0
    end if
  else
    if tObj.UNIsoundTriggerC <> 0 then
      thisPic = tObj.UNIaktPic
      if thisPic = tObj.UNIsoundTriggerC then
        thisReturn = tObj.UNIsounds
        tObj.UNIsounds = EMPTY
        tObj.UNIsoundTriggerC = 0
      end if
    end if
  end if
  return thisReturn
end
