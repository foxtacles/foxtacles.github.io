on savePos St, En
  retval = []
  repeat with n = St to En
    append(retval, n)
    append(retval, sprite(n).loc)
  end repeat
  return retval
end
