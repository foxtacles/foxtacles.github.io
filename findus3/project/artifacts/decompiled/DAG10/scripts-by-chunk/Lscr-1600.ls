global findusSpriteNumber, findusStep, maxFindusRight, maxFindusLeft, startFindusCastNumber, stopFindusCastNumber, changePictureSpeed, findusCounter, FindusNr

on moveFindus
  if the locH of sprite findusSpriteNumber < the mouseH then
    direction = 1
  end if
  if the locH of sprite findusSpriteNumber > the mouseH then
    direction = -1
  end if
  newLoch = the locH of sprite findusSpriteNumber + (findusStep * direction)
  if (newLoch > maxFindusRight) or (newLoch < maxFindusLeft) or (abs(the mouseH - newLoch) <= findusStep) then
    return 
  end if
  findusCounter = changePicture(startFindusCastNumber, stopFindusCastNumber, direction, findusSpriteNumber, findusCounter, changePictureSpeed)
  distRight = maxFindusRight - newLoch
  newLocv = 370 - (distRight * 0.56000000000000005)
  Nr = integer(distRight / findusStep)
  FindusNr = Nr
  set the memberNum of sprite 4 to 22 + Nr
  set the loc of sprite findusSpriteNumber to point(newLoch, newLocv)
end
