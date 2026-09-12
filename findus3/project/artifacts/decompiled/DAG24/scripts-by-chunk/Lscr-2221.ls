on KollaAvsnittSlut Typ
  global AktLjudAvsnitt, ljudavsnitt, bildavsnitt, nextbild, startade, AktBildAvsnitt
  slut = 1
  if Typ = 0 then
    if soundBusy(1) then
      slut = 0
    end if
    if not soundBusy(1) and (AktLjudAvsnitt < count(ljudavsnitt)) then
      clear()
      slut = 0
      AktLjudAvsnitt = AktLjudAvsnitt + 1
      CNr = ljudavsnitt[AktLjudAvsnitt]
      if (AktLjudAvsnitt <> 5) and (AktLjudAvsnitt <> 7) and (AktLjudAvsnitt <> 9) then
        puppetSound(1, member(CNr, "BerLjud"))
      end if
      AktBildAvsnitt = bildavsnitt[AktLjudAvsnitt]
      nextbild = 1
      startade = the timer
      if AktLjudAvsnitt = 5 then
        DisplayDragDjur(1)
        go("Uppfinning")
      end if
      if AktLjudAvsnitt = 7 then
        go("tomte")
      end if
      if AktLjudAvsnitt = 9 then
        FortsattEfterTomte()
      end if
    end if
  end if
  if Typ = 1 then
    puppetSound(1, 0)
    clear()
    slut = 0
    AktLjudAvsnitt = AktLjudAvsnitt + 1
    CNr = ljudavsnitt[AktLjudAvsnitt]
    puppetSound(1, member(CNr, "BerLjud"))
    AktBildAvsnitt = bildavsnitt[AktLjudAvsnitt]
    nextbild = 1
    startade = the timer
  end if
  if Typ = -1 then
    puppetSound(1, 0)
    clear()
    slut = 0
    AktLjudAvsnitt = AktLjudAvsnitt - 1
    CNr = ljudavsnitt[AktLjudAvsnitt]
    puppetSound(1, member(CNr, "BerLjud"))
    AktBildAvsnitt = bildavsnitt[AktLjudAvsnitt]
    nextbild = 1
    startade = the timer
  end if
  if AktLjudAvsnitt = 1 then
    DisplayDragDjur(2)
  else
    if AktLjudAvsnitt = 9 then
      DisplayDragDjur(1)
    else
      DisplayDragDjur(3)
    end if
  end if
  return slut
end
