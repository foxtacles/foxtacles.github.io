on SetValueInKarta position
  global lSkattKartaMatris
  ReadSkattFile()
  setAt(lSkattKartaMatris, position, 1)
  WriteSkattFile()
end

on GetSkattKartaMatris
  global lSkattKartaMatris
  ReadSkattFile()
  return lSkattKartaMatris
end

on GetValueFromKarta
  global cMaxKarta, lSkattKartaMatris
  CheckPosInLista(lSkattKartaMatris, cMaxKarta)
  if the result = #false then
    return #Full
    exit
  end if
  SlumpaNyItem(lSkattKartaMatris, cMaxKarta)
  varde = the result
  return varde
end
