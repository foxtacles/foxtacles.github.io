on walkFindusIn
  global findusSpriteNumber, startFindusCastNumber, stopFindusCastNumber, counterWalk, gameStage
  set the locV of sprite findusSpriteNumber to the locV of sprite findusSpriteNumber - 4
  counterWalk = changePicture(startFindusCastNumber, stopFindusCastNumber, 1, 17, counterWalk, 3)
  if the locV of sprite findusSpriteNumber <= 450 then
    gameStage = 3
  end if
end
