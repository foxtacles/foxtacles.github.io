on exitFrame
  repeat with i = 1 to 48
    puppetSprite(i, 0)
  end repeat
  set the keyDownScript to EMPTY
  feedback()
end
