global gBorja, flash

on beginSprite me
  gBorja = me.spriteNum
  sprite(gBorja).blend = 0
end

on mouseEnter me
  sprite(gBorja).blend = 100
  cursor([300, 301])
end

on mouseLeave me
  sprite(gBorja).blend = 0
  cursor(-1)
end

on mouseDown me
  if the mouseDown and (flash = 0) then
    cursor(-1)
    puppetSound(1, 0)
    repeat while the mouseDown = 1
      updateStage()
    end repeat
    sprite(gBorja).blend = 0
    updateStage()
    repeat with i = 1 to 48
      puppetSprite(i, 0)
    end repeat
    go("spielen")
  end if
end
