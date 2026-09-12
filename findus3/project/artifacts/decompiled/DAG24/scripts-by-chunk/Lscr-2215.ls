on checkspecial spnum
  global huvud, kropp, skor, Ljud, skosprites, huvudsprites, muschsprites, kladsprites
  if spnum = 76 then
    if skor <> 0 then
      sprite(skor).loc = getStartPos(skor)
    end if
    skor = spnum
  end if
  if spnum = 73 then
    if skor <> 0 then
      sprite(skor).loc = getStartPos(skor)
    end if
    skor = spnum
  end if
  if spnum = 79 then
    if skor <> 0 then
      sprite(skor).loc = getStartPos(skor)
    end if
    skor = spnum
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
