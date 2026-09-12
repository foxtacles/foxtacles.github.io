global ove, klar, spriteEtt, spriteTva, spriteTre, rimEtt, rimTva, rimTre, rimFyra, posEtt, posTva, posTre, rPosEtt, rPosTva, rPosTre, rPosFyra

on omstart
  unloadMember(49, 72)
  unloadMember(16)
  unloadMember(29)
  repeat with i = 13 to 21
    puppetSprite(i, 1)
    set the moveableSprite of sprite i to 1
  end repeat
  set the memberNum of sprite 13 to 11
  set the memberNum of sprite 14 to 10
  set the memberNum of sprite 15 to 9
  set the memberNum of sprite 16 to 8
  set the memberNum of sprite 17 to 7
  set the memberNum of sprite 18 to 6
  set the memberNum of sprite 19 to 5
  set the memberNum of sprite 20 to 4
  set the memberNum of sprite 21 to 3
  updateStage()
  klar = 0
  ove = 1
  platslist = [point(320, 140), point(320, 240), point(320, 340)]
  rplatslist = [point(105, 145), point(109, 300), point(525, 180), point(522, 333)]
  rimlist = []
  klapplist = []
  repeat with r = 13 to 21
    add(klapplist, r)
    add(rimlist, r - 10)
    set the visible of sprite r to 0
    set the visible of sprite (r - 10) to 0
    puppetSprite(r, 0)
    puppetSprite(r - 10, 0)
  end repeat
  set the visible of sprite 12 to 1
  updateStage()
  spriteEtt = getAt(klapplist, random(9))
  deleteOne(klapplist, spriteEtt)
  puppetSprite(spriteEtt, 1)
  posEtt = getAt(platslist, random(3))
  set the loc of sprite spriteEtt to posEtt
  deleteOne(platslist, posEtt)
  rimEtt = spriteEtt - 10
  deleteOne(rimlist, rimEtt)
  puppetSprite(rimEtt, 1)
  rPosEtt = getAt(rplatslist, random(4))
  set the loc of sprite rimEtt to rPosEtt
  deleteOne(rplatslist, rPosEtt)
  set the visible of sprite spriteEtt to 1
  set the visible of sprite rimEtt to 1
  spriteTva = getAt(klapplist, random(8))
  deleteOne(klapplist, spriteTva)
  puppetSprite(spriteTva, 1)
  posTva = getAt(platslist, random(2))
  set the loc of sprite spriteTva to posTva
  deleteOne(platslist, posTva)
  rimTva = spriteTva - 10
  deleteOne(rimlist, rimTva)
  rPosTva = getAt(rplatslist, random(3))
  set the loc of sprite rimTva to rPosTva
  deleteOne(rplatslist, rPosTva)
  set the visible of sprite spriteTva to 1
  set the visible of sprite rimTva to 1
  spriteTre = getAt(klapplist, random(7))
  deleteOne(klapplist, spriteTre)
  puppetSprite(spriteTre, 1)
  posTre = getAt(platslist, random(1))
  set the loc of sprite spriteTre to posTre
  deleteOne(platslist, posTre)
  rimTre = spriteTre - 10
  deleteOne(rimlist, rimTre)
  rPosTre = getAt(rplatslist, random(2))
  set the loc of sprite rimTre to rPosTre
  deleteOne(rplatslist, rPosTre)
  set the visible of sprite spriteTre to 1
  set the visible of sprite rimTre to 1
  rimFyra = getAt(rimlist, random(6))
  rPosFyra = getAt(rplatslist, random(1))
  set the loc of sprite rimFyra to rPosFyra
  deleteOne(rplatslist, rPosFyra)
  set the visible of sprite rimFyra to 1
  go("bygg")
end
