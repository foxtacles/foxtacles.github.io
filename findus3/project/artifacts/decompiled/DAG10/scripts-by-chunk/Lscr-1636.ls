on UNImoveInParabol totalSteps, curve, startX, startY, stopX, stopY
  returnList = []
  gravity = 10.0
  totalStepsTime = 10.0 * float(curve)
  dx = stopX - startX
  dy = stopY - startY
  velXstart = float(dx / totalStepsTime)
  velYstart = float(dy - (0.5 * gravity * totalStepsTime * totalStepsTime)) / float(totalStepsTime)
  repeat with thisStep = 1 to totalSteps
    thisStepTime = float(thisStep) / float(totalSteps) * totalStepsTime
    newX = integer((velXstart * thisStepTime) + startX)
    newY = integer((0.5 * gravity * thisStepTime * thisStepTime) + (velYstart * thisStepTime) + startY)
    if thisStepTime >= totalStepsTime then
      newX = stopX
      newY = stopY
    end if
    add(returnList, point(newX, newY))
  end repeat
  return returnList
end
