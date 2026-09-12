global gBorja

on beginSprite me
  gBorja = me.spriteNum
  sprite(gBorja).visible = 0
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
