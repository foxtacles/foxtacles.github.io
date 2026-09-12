on UniStillAnimationTimed Objnr
  global UNIObjectList
  tObj = UNIObjectList[Objnr]
  step = tObj.UNIaktStep
  pictures = tObj.UNIanimationPics
  times = tObj.UniFrameTime
  if integerp(pictures) then
    tempArray = []
    add(tempArray, pictures)
    pictures = tempArray
  end if
  if integerp(times) then
    tempArray = []
    add(tempArray, times)
    times = tempArray
  end if
  EPC = tObj.UNIendPointCounter
  if step > count(pictures) then
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
  tObj.UNIaktStep = step
  if count(pictures) > 1 then
    tObj.UNIaktPic = pictures[step]
  else
    tObj.UNIaktPic = pictures[1]
  end if
  if count(times) > 1 then
    tObj.UNIoldPicTimer = (times[step] * tObj.UNIm) + the timer
  else
    tObj.UNIoldPicTimer = (times[1] * tObj.UNIm) + the timer
  end if
end
