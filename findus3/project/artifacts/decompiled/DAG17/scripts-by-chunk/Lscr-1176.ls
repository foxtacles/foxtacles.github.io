on checkSplat
  global splatRemoveTime, elkAlive, elkSpriteNumber, startElkCastNumber, ElkDirection, numberOfPlayers
  if (the locH of sprite 35 > 0) and (the timer >= (splatRemoveTime - 10)) then
    set the loc of sprite 35 to point(-1000, -1000)
  end if
  if (splatRemoveTime > 0) and (the timer >= splatRemoveTime) then
    if numberOfPlayers = 1 then
      if ElkDirection = 1 then
        set the memberNum of sprite elkSpriteNumber to startElkCastNumber
      end if
      if ElkDirection = -1 then
        set the memberNum of sprite elkSpriteNumber to startElkCastNumber + 7
      end if
    end if
    if numberOfPlayers = 2 then
      set the memberNum of sprite elkSpriteNumber to startElkCastNumber
    end if
    elkAlive = 1
    splatRemoveTime = -1
  end if
end
