global gAntalPynt, gPyntSprite, gFarg

on exitFrame
  repeat with i = 1 to gAntalPynt
    puppetSprite(i + gPyntSprite - 1, 0)
  end repeat
  go("init")
end
