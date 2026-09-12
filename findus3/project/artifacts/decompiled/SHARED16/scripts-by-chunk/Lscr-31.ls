on ReadSkattFile
  global gPathDataFiles, gAntalGuldFeather, gAntalGuldPengar, lSkattMatris, lSkattKartaMatris, gVaktFileName
  VaktFil = new(xtra("fileio"))
  openFile(VaktFil, gPathDataFiles & gVaktFileName, 0)
  if status(VaktFil) = 0 then
    setPosition(VaktFil, 0)
    FilNamn = gPathDataFiles & gVaktFileName
    gAntalGuldFeather = value(readLine(VaktFil))
    gAntalGuldPengar = value(readLine(VaktFil))
    lSkattMatris = value(readLine(VaktFil))
    lSkattKartaMatris = value(readLine(VaktFil))
  else
    beep()
  end if
  closeFile(VaktFil)
end

on WriteSkattFile
  global gPathDataFiles, gAntalGuldFeather, gAntalGuldPengar, lSkattMatris, lSkattKartaMatris, gVaktFileName
  VaktFil = new(xtra("fileio"))
  openFile(VaktFil, gPathDataFiles & gVaktFileName, 0)
  put "lSkattKartaMatris", lSkattKartaMatris
  if status(VaktFil) = 0 then
    setPosition(VaktFil, 0)
    writeString(VaktFil, string(gAntalGuldFeather) & RETURN)
    writeString(VaktFil, string(gAntalGuldPengar) & RETURN)
    writeString(VaktFil, string(lSkattMatris) & RETURN)
    writeString(VaktFil, string(lSkattKartaMatris) & RETURN)
  else
    beep()
  end if
  closeFile(VaktFil)
end

on Rensaskattfile
  global gAntalGuldFeather, gAntalGuldPengar, lSkattMatris, lSkattKartaMatris
  gAntalGuldFeather = 0
  gAntalGuldPengar = 0
  lSkattMatris = list(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  lSkattKartaMatris = list(0, 0, 0, 0, 0, 0, 0, 0, 0)
  WriteSkattFile()
end
