on KollaOmMonsterFinns
  global SlumpMonsterList, MonsterSpriteNr, MonsterPos, HittatAktiv, AntalHittade, Hittatggr, HittatMonster, BildTimer, HittadeMonster
  Mx = the mouseH
  My = the mouseV
  HittatMonster = 0
  Tol = 35
  repeat with i = 1 to 3
    m = getAt(SlumpMonsterList, i)
    MonX = getAt(MonsterPos, m).locH
    MonY = getAt(MonsterPos, m).locV
    if (Mx > (MonX - Tol)) and (Mx < (MonX + Tol)) and (My > (MonY - Tol)) and (My < (MonY + Tol)) then
      HittatMonster = m
    end if
  end repeat
  repeat with i = 1 to AntalHittade
    if HittatMonster = getAt(HittadeMonster, i) then
      HittatMonster = 0
    end if
  end repeat
  if HittatMonster > 0 then
    put point(Mx, My), getAt(MonsterPos, m) - Tol
    Hittatggr = 0
    HittatAktiv = 1
    AntalHittade = AntalHittade + 1
    BildTimer = 0
  end if
end
