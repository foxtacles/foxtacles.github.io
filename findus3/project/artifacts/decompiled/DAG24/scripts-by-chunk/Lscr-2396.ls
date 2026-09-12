on DisplayDragDjur Typ
  LeftPos = point(200, 442)
  RightPos = point(443, 444)
  if Typ = 1 then
    sprite(100).loc = LeftPos
    sprite(101).loc = point(-1000, -1000)
  end if
  if Typ = 2 then
    sprite(100).loc = point(-1000, -1000)
    sprite(101).loc = RightPos
  end if
  if Typ = 3 then
    sprite(100).loc = LeftPos
    sprite(101).loc = RightPos
  end if
end

on InitDragAvsnitt Dnr
  global DragAvsnitt
  DragAvsnitt = Dnr
end

on FixaKlickPaDragDjur Typ
  global DragAvsnitt, AktLjudAvsnitt
  if DragAvsnitt = 1 then
    if (Typ = 2) and (AktLjudAvsnitt = 4) then
      DisplayDragDjur(1)
      go("Uppfinning")
    end if
    if (Typ = 2) and (AktLjudAvsnitt = 6) then
      go("tomte")
    end if
    if (Typ = 2) and (AktLjudAvsnitt = 8) then
      FortsattEfterTomte()
    end if
    if Typ = 1 then
      KollaAvsnittSlut(-1)
    end if
    if Typ = 2 then
      KollaAvsnittSlut(1)
    end if
  end if
  if DragAvsnitt = 2 then
    if Typ = 1 then
      puppetSound(1, 0)
      puppetSound(2, 0)
      KollaAvsnittSlut(-1)
      go("BerLoop")
    end if
    if Typ = 2 then
      puppetSound(1, 0)
      puppetSound(2, 0)
      AktLjudAvsnitt = AktLjudAvsnitt - 1
      KollaAvsnittSlut(1)
      go("BerLoop")
    end if
  end if
  if DragAvsnitt = 3 then
    if Typ = 1 then
      puppetSound(1, 0)
      puppetSound(2, 0)
      KollaAvsnittSlut(-1)
      repeat with i = 41 to 80
        set the loc of sprite i to point(-1000, -1000)
      end repeat
      go("BerLoop")
    end if
    if Typ = 2 then
      puppetSound(1, 0)
      puppetSound(2, 0)
      AktLjudAvsnitt = AktLjudAvsnitt - 1
      KollaAvsnittSlut(1)
      repeat with i = 41 to 80
        set the loc of sprite i to point(-1000, -1000)
      end repeat
      go("BerLoop")
    end if
  end if
  if DragAvsnitt = 4 then
    if Typ = 1 then
      puppetSound(1, 0)
      puppetSound(2, 0)
      KollaAvsnittSlut(-1)
      repeat with i = 41 to 80
        set the loc of sprite i to point(-1000, -1000)
      end repeat
      go("BerLoop")
    end if
    if Typ = 2 then
      puppetSound(1, 0)
      puppetSound(2, 0)
      AktLjudAvsnitt = AktLjudAvsnitt - 1
      KollaAvsnittSlut(1)
      repeat with i = 41 to 80
        set the loc of sprite i to point(-1000, -1000)
      end repeat
      go("BerLoop")
    end if
  end if
end
