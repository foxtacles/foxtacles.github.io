global gKalender, flash, gkalenderintro

on beginSprite me
  gKalender = me.spriteNum
  sprite(gKalender).blend = 0
end

on mouseEnter me
  sprite(gKalender).blend = 100
  cursor([300, 301])
end

on mouseLeave me
  sprite(gKalender).blend = 0
  cursor(-1)
end

on mouseDown me
  if the mouseDown and (flash = 0) then
    cursor(-1)
    repeat while the mouseDown = 1
      updateStage()
    end repeat
    repeat with i = 9 to 25
      sprite(i).blend = 0
    end repeat
    puppetTransition(10)
    puppetSound(1, 0)
    gkalenderintro = 0
    go("spelslut")
  end if
end
