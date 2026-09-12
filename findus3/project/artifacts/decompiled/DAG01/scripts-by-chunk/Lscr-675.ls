global gFindus, gNextCP, gCPRects, gVarvCount, gGameTime, gBumpCount, gKnappen, findusprat

on exitFrame
  if the shiftDown or the controlDown then
    if not soundBusy(1) then
      puppetSound("Œka" & random(5))
    end if
  end if
  tid = the timer
  t = tid / 13
  if t <> gGameTime then
    gGameTime = t
    putTime(tid)
  end if
  r = getAt(gCPRects, gNextCP)
  p = point(gFindus.xPos, gFindus.yPos)
  if inside(p, r) then
    if gNextCP = 1 then
      if gVarvCount = 3 then
        setturnangle(gFindus, 0)
        acc(gFindus, 0)
        putTime(tid)
        puppetSound("nurent.aif")
        findusprat = 0
        go(the frame + 1)
      end if
      gVarvCount = gVarvCount + 1
    end if
    gNextCP = gNextCP + 1
    if gNextCP > count(gCPRects) then
      gNextCP = 1
    end if
  end if
  gBumpCount = gBumpCount - 1
  s1 = 1
  s2 = gFindus.masksprite
  if sprite s1 intersects s2 then
    bounce(gFindus)
    if gBumpCount <= 0 then
      puppetSound("bumpa" & random(3))
      gBumpCount = 25
    end if
  end if
  if the shiftDown then
    acc(gFindus, 500 + 500)
  else
    if the controlDown then
      acc(gFindus, -(500 + 500))
    else
      acc(gFindus, 0)
    end if
  end if
  move(gFindus)
  doLayers()
  if not rollOver(41) then
    gKnappen = 0
  end if
  musKnapp()
  go(the frame)
end

on musKnapp
  if rollOver(40) then
    cursor([30, 31])
    if the shiftDown or the controlDown then
      exit
    end if
    set the visible of sprite 40 to 1
    updateStage()
    if the mouseDown then
      repeat while the mouseDown
        if rollOver(40) then
          set the visible of sprite 40 to 1
          cursor([30, 31])
        else
          set the visible of sprite 40 to 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(40) then
        set the visible of sprite 40 to 0
        puppetTransition(10)
        go("vidare")
      end if
    end if
    set the visible of sprite 41 to 0
    updateStage()
  else
    if rollOver(41) then
      cursor([30, 31])
      if the shiftDown or the controlDown then
        exit
      end if
      set the visible of sprite 41 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(41) then
            set the visible of sprite 41 to 1
            cursor([30, 31])
          else
            set the visible of sprite 41 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(41) then
          set the visible of sprite 41 to 0
          puppetSprite(10, 0)
          put EMPTY into field "tid_field"
          go("startgame")
          exit
        end if
      end if
      set the visible of sprite 40 to 0
      updateStage()
    else
      set the visible of sprite 40 to 0
      set the visible of sprite 41 to 0
      cursor(0)
    end if
  end if
end

on putTime tid
  s = tid / 60 mod 60
  m = tid / 3600 mod 60
  tt = 100 * (tid mod 60) / 60
  if tt < 10 then
    tt = "0" & tt
  end if
  if s < 10 then
    s = "0" & s
  end if
  put m & ":" & s & ":" & tt into field "tid_field"
end

on keyDown
  k = the key
  c = the keyCode
  case c of
    126:
    125:
    123:
      setturnangle(gFindus, 8)
    124:
      setturnangle(gFindus, -8)
  end case
end

on keyUp
  setturnangle(gFindus, 0)
end
