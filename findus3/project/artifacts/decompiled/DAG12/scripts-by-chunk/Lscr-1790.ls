on UNIfixCast ObjectNr
  global UNIObjectList
  tObj = getAt(UNIObjectList, ObjectNr)
  firstPic = tObj.UNIBasePic
  numberOfPics = tObj.UNIpicsPerAngle
  thisPic = tObj.UNIaktPic
  if thisPic = (firstPic + numberOfPics - 1) then
    thisPic = firstPic
  else
    thisPic = thisPic + 1
  end if
  tObj.UNIaktPic = thisPic
end
