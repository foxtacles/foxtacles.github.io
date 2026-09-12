on FixaNySkatt
  global lSkattMatris
  MaxAntalSkatt = 30
  ReadSkattFile()
  if the result = #FAIL then
    exit
  end if
  CheckPosInLista(lSkattMatris, MaxAntalSkatt)
  if (the result = #false) or (the result > 12) then
    return #Full
    exit
  end if
  SlumpaNyItem(lSkattMatris, MaxAntalSkatt)
  SkattNr = the result
  i = 1
  repeat while (getAt(lSkattMatris, i) <> 0) and (i < MaxAntalSkatt)
    i = i + 1
  end repeat
  setAt(lSkattMatris, i, SkattNr)
  WriteSkattFile()
  if the result = #FAIL then
    exit
  end if
  return SkattNr
end

on CheckPosInLista lista, maxItem
  repeat with i = 1 to maxItem
    if getAt(lista, i) = 0 then
      return i
      exit
    end if
  end repeat
  return #false
end

on SlumpaNyItem lista, maxItem
  bContinue = 1
  ggr = 0
  repeat while bContinue
    ggr = ggr + 1
    if ggr > 1000 then
      bContinue = 0
    end if
    r = random(maxItem)
    FinnsInte = 1
    if r > 33 then
      FinnsInte = 0
    end if
    repeat with j = 1 to maxItem
      if getAt(lista, j) = r then
        FinnsInte = 0
      end if
    end repeat
    if FinnsInte = 1 then
      return r
      exit
    end if
  end repeat
end
