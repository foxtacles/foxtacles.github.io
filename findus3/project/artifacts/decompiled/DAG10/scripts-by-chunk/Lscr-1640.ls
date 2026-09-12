on UNIcheckActiveObjects
  global UNIObjectList
  UNIreturn = []
  soundList = []
  NumberOfRepeats = count(UNIObjectList)
  repeat with i = 1 to NumberOfRepeats
    thisReturn = []
    tObj = UNIObjectList[i]
    if the timer < tObj.UNIoldPicTimer then
      next repeat
    end if
    tObj.UNIaktStep = tObj.UNIaktStep + 1
    thisMotionType = tObj.UNImotionType
    thisPath = tObj.UNIpathList
    case thisMotionType of
      1, 2:
        if tObj.UNIaktStep = 1 then
          oldAktPic = tObj.UNIaktPic - tObj.UNIBasePic
          UNIfixSteps(i, thisMotionType)
          UNIfixAngle(i)
          tObj.UNIaktPic = tObj.UNIBasePic + oldAktPic
        else
          if tObj.UNIaktStep = tObj.UNInumberOfSteps then
            tObj.UNIaktX = tObj.UNIStopX
            tObj.UNIaktY = tObj.UNIStopY
            thisPoint = getPos(thisPath, point(tObj.UNIStopX, tObj.UNIStopY))
            UNIfixCast(i)
            if (thisPoint = 1) or (thisPoint = count(thisPath)) then
              case tObj.UNIendPointCounter of
                1:
                  tObj.UNIactive = 0
                  if tObj.UNIstandSequens <> 0 then
                    if tObj.UNIanimationAngles = 1 then
                      thisAngle = 0
                    else
                      angle = tObj.UNIaktAngle
                      degPerFig = float(360) / float(tObj.UNIanimationAngles)
                      thisAngle = integer(float(angle) / float(degPerFig))
                      if thisAngle = tObj.UNIanimationAngles then
                        thisAngle = 0
                      end if
                    end if
                    tObj.UNIaktPic = tObj.UNIstandSequens + thisAngle
                  end if
                (-1):
                  tObj.UNIaktStep = 0
                  tObj.UNIpathDirection = -tObj.UNIpathDirection
                otherwise:
                  tObj.UNIendPointCounter = tObj.UNIendPointCounter - 1
                  if thisMotionType = 1 then
                    tObj.UNIpathDirection = -tObj.UNIpathDirection
                  end if
                  tObj.UNIaktStep = 0
              end case
            else
              tObj.UNIaktStep = 0
            end if
          else
            tObj.UNIaktX = tObj.UNIaktX + tObj.UNIDX
            tObj.UNIaktY = tObj.UNIaktY + tObj.UNIDY
            if (tObj.UNIaktStep mod tObj.UNIchangeCastAfter) = 0 then
              UNIfixCast(i)
            end if
          end if
        end if
        newTimer = (tObj.UniFrameTime * tObj.UNIm) + the timer
        tObj.UNIoldPicTimer = newTimer
      3, 4:
        listSize = count(thisPath)
        listPosition = getPos(thisPath, point(tObj.UNIaktX, tObj.UNIaktY))
        tObj.UNIaktStep = 0
        nextPosition = listPosition + tObj.UNIpathDirection
        if (nextPosition > listSize) and (thisMotionType = 4) then
          nextPosition = 1
        else
          if (nextPosition > listSize) and (thisMotionType = 3) then
            nextPosition = listSize - 1
            tObj.UNIpathDirection = -tObj.UNIpathDirection
          else
            if (nextPosition = 0) and (thisMotionType = 3) then
              nextPosition = 2
              tObj.UNIpathDirection = -tObj.UNIpathDirection
            end if
          end if
        end if
        nextPoint = getAt(thisPath, nextPosition)
        tObj.UNIaktX = nextPoint.locH
        tObj.UNIaktY = nextPoint.locV
        if (nextPosition = 1) or (nextPosition = listSize) then
          case tObj.UNIendPointCounter of
            1:
              tObj.UNIactive = 0
            (-1):
              nothing()
            otherwise:
              tObj.UNIendPointCounter = tObj.UNIendPointCounter - 1
          end case
        end if
        UNIfixCastJump(i, nextPosition)
      6:
        UniStillAnimationTimed(i)
    end case
    soundToStart = UNIcheckSoundTriggers(i)
    add(soundList, soundToStart)
    thisReturn = [tObj.UNIobjectNr, tObj.UNIaktX, tObj.UNIaktY, tObj.UNIaktPic, tObj.UNIactive]
    add(UNIreturn, thisReturn)
  end repeat
  newlyActivatedObjects = UniKillObj()
  addAt(UNIreturn, 1, newlyActivatedObjects)
  addAt(UNIreturn, 1, soundList)
  return UNIreturn
end
