on SlumpaFramMonster
  global SlumpMonsterList, AntalMonsterTotalt, MonsterSpriteNr, MonsterPos, HittSpriteNr
  repeat with i = 1 to AntalMonsterTotalt
    set the loc of sprite (MonsterSpriteNr + i - 1) to point(-1000, -1000)
  end repeat
  repeat with i = 1 to 3
    set the loc of sprite (HittSpriteNr + i - 1) to point(-1000, -1000)
  end repeat
  SlumpMonsterList = []
  repeat with i = 1 to 3
    MonsterOK = 0
    repeat while MonsterOK = 0
      Mon = random(AntalMonsterTotalt)
      if Mon = 6 then
        put "6"
      end if
      if i > 1 then
        MonsterOK = 1
        if Mon = 6 then
          MonsterOK = 0
        end if
        repeat with j = 1 to i - 1
          if Mon = getAt(SlumpMonsterList, j) then
            MonsterOK = 0
          end if
        end repeat
        next repeat
      end if
      if Mon <> 6 then
        MonsterOK = 1
      end if
    end repeat
    setAt(SlumpMonsterList, i, Mon)
  end repeat
  repeat with i = 1 to 3
    m = getAt(SlumpMonsterList, i)
    set the loc of sprite (MonsterSpriteNr + m - 1) to getAt(MonsterPos, m)
  end repeat
end
