on UniKillObj
  global UNIObjectList
  returnList = []
  repeat with i = 1 to count(UNIObjectList)
    tObj = UNIObjectList[i]
    if tObj.UNIactive = 0 then
      tempChain = tObj.UNIchain
      if tempChain <> [] then
        repeat with j = 1 to count(tempChain)
          thisValue = tempChain[j]
          add(returnList, thisValue)
        end repeat
      end if
      deleteAt(UNIObjectList, i)
    end if
  end repeat
  return returnList
end
