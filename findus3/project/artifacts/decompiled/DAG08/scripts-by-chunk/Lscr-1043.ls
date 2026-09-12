global gBorja

on beginSprite me
  gBorja = me.spriteNum
end

on exitFrame me
  knappar()
end

on mouseEnter me
  cursor([192, 193])
end

on mouseLeave me
  cursor(-1)
end

on mouseDown me
  cursor(-1)
end
