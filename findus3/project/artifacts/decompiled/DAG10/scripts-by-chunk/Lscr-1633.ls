on UniStillAnimation Objnr
  global UNIObjectList
  tObj = UNIObjectList[Objnr]
  basePic = tObj.UNIBasePic
  picsPerAngle = tObj.UNIpicsPerAngle
  EPC = tObj.UNIendPointCounter
  step = tObj.UNIaktStep
  waitTime = tObj.UniFrameTime
  if (basePic + step) >= (basePic + picsPerAngle) then
    case EPC of
      1:
        tObj.UNIactive = 0
        return 
      (-1):
        step = 1
      otherwise:
        tObj.UNIendPointCounter = tObj.UNIendPointCounter - 1
        step = 1
    end case
  end if
  tObj.UNIaktPic = basePic + step - 1
  tObj.UNIaktStep = step
  tObj.UNIoldPicTimer = (waitTime * tObj.UNIm) + the timer
end
