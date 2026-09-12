global TomteSprites

on checktomte spnum
  global huvud, musch, kropp, skor, Ljud
  cn = getclass(spnum)
  FixaGrej(spnum, cn)
  if spnum = 76 then
    FixaGrej(spnum, 3)
  end if
  if spnum = 73 then
    FixaGrej(spnum, 3)
  end if
  if spnum = 79 then
    FixaGrej(spnum, 3)
  end if
  if spnum = 66 then
    puppetSound(2, "Tomte01")
  end if
  if spnum = 67 then
    puppetSound(2, "Tomte02")
  end if
  if spnum = 68 then
    puppetSound(2, "Tomte03")
  end if
  if spnum = 69 then
    puppetSound(2, "Tomte04")
  end if
end

on FixaGrej SpNr, Class
  TB = TomteSprites[Class]
  if TomteSprites[Class] <> 0 then
    sprite(TomteSprites[Class]).loc = getStartPos(TomteSprites[Class])
  end if
  TomteSprites[Class] = SpNr
  p = getOne(TomteSprites, TB)
  if p > 0 then
    TomteSprites[p] = 0
  end if
end

on getclass spnum
  global skosprites, huvudsprites, Ljudsprites, kladsprites
  if getOne(skosprites, spnum) <> 0 then
    return 3
  end if
  if getOne(huvudsprites, spnum) <> 0 then
    return 1
  end if
  if getOne(Ljudsprites, spnum) <> 0 then
    return 4
  end if
  if getOne(kladsprites, spnum) <> 0 then
    return 2
  end if
end
