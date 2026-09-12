on exitFrame
  global b
  b = 1
  sound stop 2
  sprite(23).visible = 0
  sprite(24).visible = 0
  repeat while the volume of sound 2 < 255
    set the volume of sound 2 to the volume of sound 2 + 10
    Wait(6)
  end repeat
  puppetSound(1, "VERS.AIF")
  puppetTransition(9)
  go(the frame + 1)
end
