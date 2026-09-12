on FixaKagla
  global flash, TidX, TidY, InitVoice, HittatAktiv
  if the mouseDown = 1 then
    if InitVoice = 0 then
      InitVoice = 1
      findusprat(1)
    end if
    if flash = 0 then
      puppetSound(1, "NyFx01")
      flash = 1
      set the loc of sprite 30 to point(-1000, -1000)
      NollStallFangaTimer(1)
    end if
    X = the mouseH
    Y = the mouseV
    NewPos = 0
    if (point(X, Y) <= point(TidX + 10, TidY + 10)) and (point(X, Y) >= point(TidX - 10, TidY - 10)) then
    else
      NewPos = 1
      TidX = X
      TidY = Y
      NollStallFangaTimer(1)
    end if
    if X < -66 then
      X = -66
    end if
    if X > 715 then
      X = 715
    end if
    if Y < -68 then
      Y = -68
    end if
    if Y > 550 then
      Y = 550
    end if
    set the loc of sprite 31 to point(X, Y)
  else
    if flash = 1 then
      flash = 0
      puppetSound(1, "NyFx01")
      set the loc of sprite 30 to point(320, 240)
      set the loc of sprite 31 to point(-1000, -1000)
      NollStallFangaTimer(0)
    end if
  end if
end
