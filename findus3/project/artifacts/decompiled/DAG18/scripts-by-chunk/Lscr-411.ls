global stanna, b

on exitFrame
  unloadMember()
  stanna = 0
  sprite(14).visible = 1
  sprite(8).visible = 0
  set the volume of sound 2 to 255
  b = integer((the frame + 1) / 5)
end
