on removespaces inword
  if inword starts " " then
    lword = removespaces(char 2 to (the number of chars in inword) of inword)
  else
    if char (the number of chars in inword) of inword = " " then
      lword = removespaces(char 1 to (the number of chars in inword - 1) of inword)
    else
      lword = inword
    end if
  end if
  return lword
end

on removelb inword
  if inword starts numToChar(10) then
    lword = removelb(char 2 to (the number of chars in inword) of inword)
  else
    if char (the number of chars in inword) of inword = numToChar(10) then
      lword = removelb(char 1 to (the number of chars in inword - 1) of inword)
    else
      lword = inword
    end if
  end if
  return lword
end

on is_in_field aline, afield
  thefield = afield
  repeat with X = 1 to the number of lines in field afield
    if line X of field afield = aline then
      return 1
    end if
  end repeat
  return 0
end
