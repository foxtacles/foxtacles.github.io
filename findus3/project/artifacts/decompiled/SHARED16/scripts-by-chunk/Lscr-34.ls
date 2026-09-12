on SetGuldFeather
  WriteSkattFile()
end

on AddGuldFeather
  global gAntalGuldFeather
  ReadSkattFile()
  gAntalGuldFeather = gAntalGuldFeather + 1
  WriteSkattFile()
end
