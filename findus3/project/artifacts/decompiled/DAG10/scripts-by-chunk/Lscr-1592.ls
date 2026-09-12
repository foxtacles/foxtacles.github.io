on moveObjectInParabola gravity, timeStep, timeInMotion, velXstart, velYstart, startX, startY, currentSprite
  newX = (velXstart * timeInMotion) + startX
  newY = (0.5 * gravity * timeInMotion * timeInMotion) + (velYstart * timeInMotion) + startY
  set the locH of sprite currentSprite to newX
  set the locV of sprite currentSprite to newY
  timeInMotion = timeInMotion + timeStep
  return timeInMotion
end
