on NollStallFangaTimer Typ
  global FangaTimer
  if Typ = 0 then
    FangaTimer = the timer + (50 * 60)
  end if
  if Typ = 1 then
    FangaTimer = the timer + float(0 * 60)
  end if
end
