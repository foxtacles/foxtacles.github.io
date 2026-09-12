on CheckMouseDownEvent
  global cCursorKanal, clSpikSpriteNum, bAktivCursor, gLatestHit, lSpikObjMatris, HammareFunkar
  if bAktivCursor = 1 then
    exit
  end if
  if HammareFunkar < 2 then
    exit
  end if
  gLatestHit = CheckMouseHit()
  if gLatestHit = 0 then
    set the loc of sprite cCursorKanal to point(the mouseH, the mouseV)
  else
    cursor(200)
    thisNumOfHits = getAntalNedslag(getAt(lSpikObjMatris, gLatestHit))
    set the locH of sprite cCursorKanal to the locH of sprite getAt(clSpikSpriteNum, gLatestHit)
    set the locV of sprite cCursorKanal to the locV of sprite getAt(clSpikSpriteNum, gLatestHit) - 4 + (3 * thisNumOfHits)
    SetSpikBeingHit(getAt(lSpikObjMatris, gLatestHit))
  end if
  bAktivCursor = 1
end

on AnimeraCursor
  global cCursorKanal, cStartCursorCast, cAntalCursorCast, cCursorTimeDelay, bAktivCursor, gCursorCastCounter, gLatestCursorChange, lSpikObjMatris, gLatestHit
  if bAktivCursor = 0 then
    exit
  end if
  if gLatestCursorChange < the ticks then
    gLatestCursorChange = the ticks + cCursorTimeDelay
    gCursorCastCounter = gCursorCastCounter + 1
    if gCursorCastCounter > cAntalCursorCast then
      gCursorCastCounter = 0
      bAktivCursor = 0
      set the loc of sprite cCursorKanal to the mouseLoc
      if gLatestHit > 0 then
        Hit(getAt(lSpikObjMatris, gLatestHit))
      end if
      exit
    end if
    set the memberNum of sprite cCursorKanal to cStartCursorCast + gCursorCastCounter
  end if
end

on CheckMouseHit
  global clSpikSpriteNum, cCursorKanal, cXMusTolerans, cYMusTolerans, AjaBaja
  xMus = the mouseH
  yMus = the mouseV
  repeat with i = 1 to 4
    xObj = the locH of sprite getAt(clSpikSpriteNum, i)
    yObj = the locV of sprite getAt(clSpikSpriteNum, i)
    if ((xObj - cXMusTolerans) < xMus) and (xMus < (xObj + cXMusTolerans)) then
      if ((yObj - cYMusTolerans) < yMus) and (yMus < (yObj + cYMusTolerans)) then
        return i
      end if
    end if
  end repeat
  return 0
end
