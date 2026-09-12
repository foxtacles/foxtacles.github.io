on TaFramHittad
  global AntalHittade, Hittatggr, HittadBild, HittatAktiv, HittSpriteNr, HittatMonster, BildTimer, MonsterPos, MonsterSpriteNr, HittadeMonster, hittY, dx, dy, MDy, Mdx, SpeletSlut
  if Hittatggr = 0 then
    HittadBild = 0
    Hittatggr = 1
    add(HittadeMonster, HittatMonster)
    set the loc of sprite (MonsterSpriteNr + HittatMonster - 1) to point(-1000, -1000)
    hittY = 0
    dx = 0
    dy = 0
    Mdx = 0
    MDy = 0
    puppetSound(1, 130 + random(25) - 1)
  end if
  BildTimer = the timer + 5
  Bild = 30 + ((HittatMonster - 1) * 10) + HittadBild
  set the member of sprite (HittSpriteNr + AntalHittade - 1) to Bild
  if Hittatggr = 1 then
    hittY = hittY - 3
  end if
  if Hittatggr = 2 then
    hittY = hittY + 3
  end if
  Mdx = Mdx + dx
  MDy = MDy + dy
  X = getAt(MonsterPos, HittatMonster).locH + Mdx
  Y = getAt(MonsterPos, HittatMonster).locV + hittY + MDy
  set the loc of sprite (HittSpriteNr + AntalHittade - 1) to point(X, Y)
  HittadBild = HittadBild + 1
  if HittadBild = 7 then
    HittadBild = 2
    Hittatggr = Hittatggr + 1
    if Hittatggr = 5 then
      dx = float(440 + ((AntalHittade - 1) * 75) - X) / float(25)
      dy = float(30 - Y) / float(25)
      if AntalHittade = 1 then
        findusprat(2)
      end if
      if AntalHittade = 2 then
        findusprat(2 + random(2))
      end if
      if AntalHittade = 3 then
        findusprat(4 + random(2))
      end if
    end if
    if Hittatggr = 10 then
      HittatAktiv = 0
      HittatMonster = 0
      set the loc of sprite (HittSpriteNr + AntalHittade - 1) to point(440 + ((AntalHittade - 1) * 75), 30)
      updateStage()
      if AntalHittade = 3 then
        SpeletSlut = 1
      end if
    end if
  end if
end
