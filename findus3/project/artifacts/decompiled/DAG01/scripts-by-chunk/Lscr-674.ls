global gFindus, gNextCP, gVarvCount

on exitFrame
  sound stop 2
  puppetSound(0)
  s = 10
  X = the locH of sprite s
  Y = the locV of sprite s
  gFindus = new(script("findus_script"), s, 100, 2, 41, X, Y)
  gNextCP = 1
  gVarvCount = 0
  put " " into field "tid_field"
  unLoad(1, 9)
  unloadMember(member(55))
  unloadMember(member(81))
  preloadMember(member(100), 123)
  cursor(4)
  set the volume of sound 2 to 255
  go("startanim")
end
