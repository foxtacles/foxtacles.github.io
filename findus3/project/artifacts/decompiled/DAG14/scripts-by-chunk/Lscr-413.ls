on omstart
  global klar, ove, fyfyra, fyfem, fysex, fysju, fyatta, fynio, fetio, feett, fetva, fetre, fefyra, fefem, fesex, fesju, featta, fenio, setio, seett, setva, setre, sefyra, sefem, sesex, aktiv
  klar = 0
  aktiv = 0
  unloadMember()
  set the loc of sprite 12 to point(0, 0)
  set the loc of sprite 21 to point(181, 159)
  set the loc of sprite 24 to point(533, 93)
  set the loc of sprite 25 to point(598, 230)
  set the loc of sprite 26 to point(79, 321)
  set the loc of sprite 27 to point(-4, 361)
  set the loc of sprite 28 to point(30, 60)
  set the loc of sprite 29 to point(219, 2)
  set the loc of sprite 30 to point(123, -6)
  set the loc of sprite 31 to point(203, 187)
  set the loc of sprite 32 to point(1, 55)
  set the loc of sprite 33 to point(536, 80)
  fyfyra = 0
  fyfem = 0
  fysex = 0
  fysju = 0
  fyatta = 0
  fynio = 0
  fetio = 0
  feett = 0
  fetva = 0
  fetre = 0
  fefyra = 0
  fefem = 0
  fesex = 0
  fesju = 0
  featta = 0
  fenio = 0
  setio = 0
  seett = 0
  setva = 0
  setre = 0
  sefyra = 0
  repeat with chan = 21 to 33
    set the moveableSprite of sprite chan to 1
  end repeat
  repeat with kan = 44 to 64
    puppetSprite(kan, 0)
  end repeat
  set the moveableSprite of sprite 22 to 0
  set the moveableSprite of sprite 23 to 0
  updateStage()
  ove = 1
  go("bygg")
end
