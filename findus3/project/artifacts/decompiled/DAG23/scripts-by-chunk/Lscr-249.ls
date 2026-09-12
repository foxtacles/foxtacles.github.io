property spriteNum, castNum, currpos

on new me, spritenum0
  spriteNum = spritenum0
  castNum = the memberNum of sprite spriteNum
  xPos = the locH of sprite spriteNum
  yPos = the locV of sprite spriteNum
  currpos = point(xPos, yPos)
  puppetSprite(spriteNum, 1)
  return me
end

on setpos me, pos
  currpos = pos
  set the loc of sprite spriteNum to currpos
end

on setsprite me, sp
  spriteNum = sp
  set the loc of sprite spriteNum to currpos
  set the memberNum of sprite spriteNum to castNum
end
