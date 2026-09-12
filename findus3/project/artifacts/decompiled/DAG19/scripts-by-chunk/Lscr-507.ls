on is_in_list sak, lista
  repeat with X = 1 to count(lista)
    if getAt(lista, X) = sak then
      return X
    end if
  end repeat
  return 0
end

on deletefromlist sak, lista
  repeat with X = 1 to count(lista)
    if getAt(lista, X) = sak then
      deleteAt(lista, X)
      exit repeat
    end if
  end repeat
end

on crlist first, last, loop
  utlist = []
  if first < last then
    repeat with X = first to last
      add(utlist, X)
    end repeat
    if loop then
      repeat with X = last - 1 down to first
        add(utlist, X)
      end repeat
    end if
  else
    repeat with X = first down to last
      add(utlist, X)
    end repeat
    if loop then
      repeat with X = last + 1 to first
        add(utlist, X)
      end repeat
    end if
  end if
  return utlist
end

on listcopy list1
  list2 = []
  repeat with ordnr in list1
    add(list2, ordnr)
  end repeat
  return list2
end

on fill_list lista, Antal, varde
  if (count(lista) = Antal) or (count(lista) > Antal) then
    return lista
  else
    repeat while count(lista) < Antal
      addAt(lista, count(lista) + 1, varde)
    end repeat
    return lista
  end if
end
