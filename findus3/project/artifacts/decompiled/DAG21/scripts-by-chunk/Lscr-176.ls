global gGameSize, gTileSize, gTileArray, gEmptyPos, gTileSprite, gTileCast, gGameXPos, gGameYPos

on init_game gamesize, tilesize, tilesprite, tilecast, gamexpos, gameypos
  gGameSize = gamesize
  gTileSize = tilesize
  gTileSprite = tilesprite
  gTileCast = tilecast
  gGameXPos = gamexpos
  gGameYPos = gameypos
  gTileArray = list()
  repeat with i = 1 to gGameSize * gGameSize
    sp = gTileSprite + i - 1
    X = gGameXPos + ((i - 1) mod gGameSize * gTileSize)
    Y = gGameYPos + ((i - 1) / gGameSize * gTileSize)
    puppetSprite(sp, 1)
    set the locH of sprite sp to X
    set the locV of sprite sp to Y
    if i < (gGameSize * gGameSize) then
      set the memberNum of sprite sp to gTileCast + i - 1
      add(gTileArray, i)
      next repeat
    end if
    set the memberNum of sprite (gTileSprite + (gGameSize * gGameSize) - 1) to 0
    add(gTileArray, 0)
  end repeat
  gEmptyPos = gGameSize * gGameSize
end

on render_game
  repeat with i = 1 to gGameSize * gGameSize
    t = getAt(gTileArray, i)
    if t <> 0 then
      set the memberNum of sprite (gTileSprite + i - 1) to gTileCast + t - 1
      next repeat
    end if
    set the memberNum of sprite (gTileSprite + i - 1) to 0
  end repeat
  updateStage()
end

on movetile tilepos
  c = getAt(gTileArray, tilepos)
  X = (tilepos - 1) mod gGameSize
  Y = (tilepos - 1) / gGameSize
  if Y > 0 then
    c2 = getAt(gTileArray, tilepos - gGameSize)
    if c2 = 0 then
      exchange(tilepos - gGameSize, tilepos)
      return 1
    end if
  end if
  if Y < (gGameSize - 1) then
    c2 = getAt(gTileArray, tilepos + gGameSize)
    if c2 = 0 then
      exchange(tilepos + gGameSize, tilepos)
      return 1
    end if
  end if
  if X > 0 then
    c2 = getAt(gTileArray, tilepos - 1)
    if c2 = 0 then
      exchange(tilepos - 1, tilepos)
      return 1
    end if
  end if
  if X < (gGameSize - 1) then
    c2 = getAt(gTileArray, tilepos + 1)
    if c2 = 0 then
      exchange(tilepos + 1, tilepos)
      return 1
    end if
  end if
  return 0
end

on exchange tilepos1, tilepos2
  c1 = getAt(gTileArray, tilepos1)
  c2 = getAt(gTileArray, tilepos2)
  if c1 = 0 then
    gEmptyPos = tilepos2
  else
    if c2 = 0 then
      gEmptyPos = tilepos1
    end if
  end if
  setAt(gTileArray, tilepos1, c2)
  setAt(gTileArray, tilepos2, c1)
end

on shuffle num
  repeat with i = 1 to num
    Ok = 1
    repeat while Ok
      dir = random(4)
      case dir of
        1:
          pos = gEmptyPos - gGameSize
        2:
          pos = gEmptyPos + gGameSize
        3:
          pos = gEmptyPos - 1
        4:
          pos = gEmptyPos + 1
      end case
      if (pos >= 1) and (pos <= (gGameSize * gGameSize)) then
        Ok = movetile(pos)
      end if
    end repeat
    render_game()
    updateStage()
  end repeat
end

on check_completed
  repeat with i = 1 to (gGameSize * gGameSize) - 1
    c = getAt(gTileArray, i)
    if c <> i then
      return 0
    end if
  end repeat
  return 1
end

on clear_tiles
  repeat with i = 1 to 5 * 5
    puppetSprite(gTileSprite + i - 1, 1)
    set the memberNum of sprite (gTileSprite + i - 1) to 0
  end repeat
end
