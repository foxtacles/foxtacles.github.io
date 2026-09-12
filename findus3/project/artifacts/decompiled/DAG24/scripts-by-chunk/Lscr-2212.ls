on fixpos
  skosprites = []
  startpos = []
  repeat with n = 42 to 80
    append(skosprites, n)
    append(startpos, n)
    append(startpos, sprite(n).loc)
  end repeat
  put skosprites, startpos
end
