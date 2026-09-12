on UNIcreateUniObject ObjectNr, MotionType, EPC, path, CS, chain, SS
  global gameObjectList, UNIObjectList
  repeat with i = 1 to count(UNIObjectList)
    if UNIObjectList[i].UNIobjectNr = ObjectNr then
      deleteAt(UNIObjectList, i)
      i = i - 1
    end if
  end repeat
  uniobj = new(script("UniInitObjects"))
  add(UNIObjectList, uniobj)
  tObj = UNIObjectList[count(UNIObjectList)]
  sourceObj = gameObjectList[ObjectNr]
  tObj.UNIactive = 1
  tObj.UNIanimationAngles = sourceObj.AnimVinklar
  tObj.UNIpixelsPerStep = sourceObj.PixelPerSteg
  tObj.UNIchangeCastAfter = sourceObj.BytBildVidSteg
  tObj.UNIm = sourceObj.m
  tObj.UNIdraggable = sourceObj.DraOK
  tObj.UNIpathList = path
  tObj.UNIaktX = path[1].locH
  tObj.UNIaktY = path[1].locV
  tObj.UNIobjectNr = ObjectNr
  tObj.UNImotionType = MotionType
  tObj.UNIendPointCounter = EPC
  tObj.UniAction = CS
  if listp(chain) and (chain <> []) then
    tObj.UNIchain = chain
  end if
  if integerp(SS) then
    soundData = sourceObj.soundSequens[SS]
    code = soundData[1]
    tObj.UNIsounds = soundData[3]
    case code of
      "P":
        tObj.UNIsoundTriggerP = soundData[2]
      "C":
        tObj.UNIsoundTriggerC = soundData[2]
    end case
  end if
  sourceObj.aktivAction = CS
  case MotionType of
    1, 2:
      tObj.UNIstartCastNr = sourceObj.StartcastNr[CS]
      tObj.UNIstopCastNr = sourceObj.SlutcastNr[CS]
      tObj.UNIcastIntervall = sourceObj.CastIntervall[CS]
      picSpread = tObj.UNIstopCastNr - tObj.UNIstartCastNr + 1
      picTotal = (picSpread + tObj.UNIcastIntervall) / tObj.UNIanimationAngles
      tObj.UNIpicsPerAngle = picTotal - tObj.UNIcastIntervall
      tObj.UniFrameTime = sourceObj.FrameTime[CS]
      tObj.UNIstandSequens = sourceObj.standSequens[CS]
    3, 4:
      tObj.UNIanimationPics = sourceObj.Animation_bilder[CS]
      tObj.UniFrameTime = sourceObj.FrameTime[CS]
    5:
      tObj.UNIstartCastNr = sourceObj.StartcastNr[CS]
      tObj.UNIstopCastNr = sourceObj.SlutcastNr[CS]
      tObj.UniFrameTime = sourceObj.FrameTime[CS]
      tObj.UNIstandSequens = sourceObj.standSequens[CS]
    6:
      tObj.UniFrameTime = sourceObj.FrameTime[CS]
      tObj.UNIanimationPics = sourceObj.Animation_bilder[CS]
  end case
  tObj.UNIoldPicTimer = the timer
end
