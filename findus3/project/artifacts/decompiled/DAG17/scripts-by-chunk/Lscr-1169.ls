on exitFrame
  global oldTimer, ElkGameOver, ballALive
  if the milliSeconds > (oldTimer + 24) then
    oldTimer = the milliSeconds
    mainLoop()
  end if
  if (ballALive = 0) and (ElkGameOver = 1) then
    removeBall()
    updateStage()
    endGame()
  end if
  go(the frame)
end
