on omstart
  global klar, ove, aktiv
  unloadMember(29)
  unloadMember(40)
  unloadMember(78)
  klar = 0
  aktiv = 0
  set the loc of sprite 12 to point(0, 0)
  set the loc of sprite 14 to point(519, 411)
  set the loc of sprite 15 to point(569, 364)
  set the loc of sprite 16 to point(447, 362)
  set the loc of sprite 17 to point(546, 384)
  set the loc of sprite 18 to point(559, 378)
  set the loc of sprite 19 to point(483, 409)
  set the loc of sprite 20 to point(493, 361)
  repeat with chan = 14 to 20
    set the moveableSprite of sprite chan to 1
  end repeat
  updateStage()
  ove = 1
  go("bygg")
end
