on TryckJaDjur
  global SmaDjur1Sprite, SmaDjur2Sprite, NyAvsnitt, AktRitning
  set the blend of sprite SmaDjur1Sprite to 0
  set the blend of sprite SmaDjur2Sprite to 0
  MakePettsonTalk(0)
  repeat with i = 1 to 48
    puppetSprite(i, 0)
  end repeat
  Kstr = string(AktRitning)
  if length(Kstr) = 1 then
    Kstr = "0" & Kstr
  end if
  Kstr = "KONSTR" & Kstr
  go("spielen", Kstr)
end
