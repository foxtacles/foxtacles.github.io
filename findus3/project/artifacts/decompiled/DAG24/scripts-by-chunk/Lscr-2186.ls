on exitFrame
  global TomteMoveTimer, Tomteggr, TomteSprites, startsprites
  if (the timer > TomteMoveTimer) and (Tomteggr > 0) then
    TomteMoveTimer = the timer + 10
    sprite(startsprites[1]).locH = sprite(startsprites[1]).locH - 1
    repeat with i = 1 to 4
      if TomteSprites[i] > 0 then
        sprite(TomteSprites[i]).locH = sprite(TomteSprites[i]).locH - 1
      end if
    end repeat
    Tomteggr = Tomteggr + 1
    if Tomteggr = 70 then
      Tomteggr = 0
    end if
  end if
  if soundBusy(1) = 0 then
    go(the frame + 1)
  else
    go(the frame)
  end if
end
