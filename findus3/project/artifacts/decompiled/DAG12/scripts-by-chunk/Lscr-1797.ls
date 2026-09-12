on UNIfixCastJump ObjectNr, position
  global UNIObjectList, tObj
  tObj = getAt(UNIObjectList, ObjectNr)
  PicList = tObj.UNIanimationPics
  if integerp(PicList) then
    tObj.UNIaktPic = PicList
  else
    tObj.UNIaktPic = PicList[position]
  end if
  timeList = tObj.UniFrameTime
  if integerp(timeList) then
    tObj.UNIoldPicTimer = (timeList * tObj.UNIm) + the timer
  else
    tObj.UNIoldPicTimer = (timeList[position] * tObj.UNIm) + the timer
  end if
end
