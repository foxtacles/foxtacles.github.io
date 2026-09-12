on UNIfixAngle ObjectNr
  global UNIObjectList
  tObj = getAt(UNIObjectList, ObjectNr)
  if tObj.UNIanimationAngles = 1 then
    tObj.UNIBasePic = tObj.UNIstartCastNr
    tObj.UNIaktPic = tObj.UNIBasePic
    return 
  end if
  dx = tObj.UNIDX
  dy = tObj.UNIDY
  startCast = tObj.UNIstartCastNr
  intervall = tObj.UNIcastIntervall
  pics = tObj.UNIpicsPerAngle
  angle = 0
  if (dy = 0) and (dx > 0) then
    angle = 0
  else
    if (dy = 0) and (dx < 0) then
      angle = 180
    else
      if (dx = 0) and (dy > 0) then
        angle = 90
      else
        if (dx = 0) and (dy < 0) then
          angle = 270
        else
          angle = 180 * atan(dy / dx) / PI
          if angle < 0 then
            angle = -angle
          end if
          if (dx < 0) and (dy > 0) then
            angle = 180 - angle
          end if
          if (dx < 0) and (dy < 0) then
            angle = 180 + angle
          end if
          if (dx > 0) and (dy < 0) then
            angle = 360 - angle
          end if
        end if
      end if
    end if
  end if
  degPerFig = float(360) / float(tObj.UNIanimationAngles)
  thisAngle = integer(float(angle) / float(degPerFig))
  if thisAngle = tObj.UNIanimationAngles then
    thisAngle = 0
  end if
  basePic = startCast + ((pics + intervall) * thisAngle)
  tObj.UNIBasePic = basePic
  tObj.UNIaktPic = basePic
  tObj.UNIaktAngle = angle
end
