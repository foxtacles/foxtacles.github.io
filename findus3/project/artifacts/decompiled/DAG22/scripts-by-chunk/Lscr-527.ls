on exitFrame
  cursor(200)
  puppetSprite(31, 1)
  set the visible of sprite 5 to 0
  set the visible of sprite 6 to 0
  repeat while the volume of sound 2 < 100
    set the volume of sound 2 to the volume of sound 2 + 10
    Wait(6)
  end repeat
  puppetSound(1, "rim")
  puppetTransition(9)
  go("meny")
end
