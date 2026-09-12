global gKalender

on beginSprite me
  gKalender = me.spriteNum
  sprite(gKalender).visible = 0
end

on exitFrame me
  knappar()
end

on mouseEnter me
  cursor([73, 74])
end

on mouseLeave me
  cursor(-1)
end

on mouseDown me
  cursor(-1)
end
