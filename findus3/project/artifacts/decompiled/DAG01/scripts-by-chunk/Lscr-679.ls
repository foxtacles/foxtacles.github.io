global gGameTime, gBumpCount

on exitFrame
  gGameTime = -1
  set the timer to 0
  gBumpCount = 0
  sound stop 2
  unloadMember(member(43), 48)
end
