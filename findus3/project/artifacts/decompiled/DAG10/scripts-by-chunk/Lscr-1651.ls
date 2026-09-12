global gBorja, flash, G_BrorFirstTime

on beginSprite me
  gBorja = me.spriteNum
  sprite(gBorja).blend = 0
end

on mouseEnter me
  sprite(gBorja).blend = 100
  cursor([6, 7])
end

on mouseLeave me
  sprite(gBorja).blend = 0
  cursor(-1)
end

on mouseDown me
  if the mouseDown and (flash = 0) then
    cursor(-1)
    G_BrorFirstTime = 1
    repeat while the mouseDown = 1
      updateStage()
    end repeat
    puppetSound(1, 0)
    sprite(gBorja).blend = 0
    updateStage()
    go("spielen")
  end if
end
