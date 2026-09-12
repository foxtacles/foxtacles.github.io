on exitFrame
  go(the frame)
end

on keyDown
  if the key = RETURN then
    repeat with n = 1 to 12
      puppetSprite(n, 0)
    end repeat
    go(6)
  end if
end
