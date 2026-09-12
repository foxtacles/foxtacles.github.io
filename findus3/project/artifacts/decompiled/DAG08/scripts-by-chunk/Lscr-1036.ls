on findusprat Nr
  global FirstTime
  if Nr = 1 then
    Ljud = 120
  end if
  if Nr = 2 then
    Ljud = 122
  end if
  if Nr = 3 then
    Ljud = 123
  end if
  if Nr = 4 then
    Ljud = 124
  end if
  if Nr = 5 then
    Ljud = 126
  end if
  if Nr = 6 then
    Ljud = 127
  end if
  if Nr = 7 then
    Ljud = 128
  end if
  NoSound = 0
  if (FirstTime = 1) and (Nr = 1) then
    FirstTime = 0
  end if
  if (FirstTime = 0) and (Nr = 1) then
    NoSound = 1
  end if
  if Nr = 7 then
    NoSound = 1
  end if
  if NoSound = 0 then
    puppetSound(2, Ljud)
  end if
end
