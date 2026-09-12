on initvar
  global flash, AntalMonsterTotalt, MonsterPos, MonsterSpriteNr, FangaTimer, HittSpriteNr, AntalHittade, HittatAktiv, Hittatggr, HittadeMonster, InitVoice, SpeletSlut
  MonsterPos = [point(133, 130), point(205, 185), point(360, 327), point(69, 355), point(596, 260), point(210, 48), point(450, 380), point(352, 166)]
  AntalMonsterTotalt = 8
  MonsterSpriteNr = 7
  NollStallFangaTimer(0)
  SpeletSlut = 0
  flash = 0
  HittSpriteNr = 36
  AntalHittade = 0
  HittatAktiv = 0
  HittadeMonster = []
  InitVoice = 0
  SlumpaFramMonster()
end
