on exitFrame
  global AntalObjekt, spriteNum
  init2()
  repeat with i = 1 to AntalObjekt
    puppetSprite(i, getAt(spriteNum, i))
    set the visible of sprite getAt(spriteNum, i) to 0
  end repeat
end
