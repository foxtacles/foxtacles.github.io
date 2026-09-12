on KOLLAKOORDINATER SpriteNr
  global AntalVerktygsObjekt, spriteNum, StartXPos, StartYPos, AntalObjekt, XposV, YposV, BildIVerktygsLada, ObjektAktivProfil, ObjektAktiv, IntroSound, AntalggrObjekt, SlutForObjekt, StartbildEfterLoop, StartbildObjekt, AntalLoopObjekt, AntalggrEfterLoop, StartbildObjekt2, VerktygsObjekt
  Tolerans = 30
  IntroSound = 1
  ObjNum = 0
  repeat with ObjektNum = 1 to AntalVerktygsObjekt
    if getaProp(spriteNum, ObjektNum) = SpriteNr then
      ObjNum = ObjektNum
    end if
  end repeat
  if ObjNum = 0 then
    exit
  end if
  SpNr = getaProp(spriteNum, ObjNum)
  SpOk = 0
  SpX = getaProp(StartXPos, ObjNum)
  SpY = getaProp(StartYPos, ObjNum)
  if (the locH of sprite SpNr >= (SpX - Tolerans)) and (the locH of sprite SpNr <= (SpX + Tolerans)) and (the locV of sprite SpNr >= (SpY - Tolerans)) and (the locV of sprite SpNr <= (SpY + Tolerans)) then
    setAt(ObjektAktiv, ObjNum, getAt(ObjektAktivProfil, ObjNum))
  else
    setAt(ObjektAktiv, ObjNum, 0)
  end if
  if GA(2) > 0 then
    setAt(Oknggr, 1, 3)
  end if
  if GA(2) = 0 then
    setAt(Oknggr, 1, 1)
  end if
  if GA(8) > 0 then
    SA(8, 0)
    setAt(VerktygsObjekt, 8, 0)
    SA(7, 1)
    SA(5, 0)
  end if
  if (GA(3) > 0) and (GA(2) = 0) then
    SA(3, 4)
  end if
  if (GA(3) > 0) and (GA(2) > 0) then
    SA(3, 1)
  end if
  if (GA(4) > 0) and (GA(3) > 0) then
    if GA(2) > 0 then
      SA(4, 1)
    else
      SA(4, 4)
    end if
  else
    SA(4, 0)
  end if
  if (GA(2) > 0) and (GA(3) > 0) and (GA(4) > 0) and (GA(7) = 0) then
    SA(5, 1)
  end if
  if (GA(7) > 0) and (GA(2) > 0) and (GA(3) > 0) and (GA(4) > 0) then
    SA(7, 1)
    SA(6, 1)
  else
    if GA(7) > 0 then
      SA(7, 4)
    end if
    SA(6, 4)
  end if
  PlaceraUtObjekt()
end

on GA Nr
  global ObjektAktiv
  return getAt(ObjektAktiv, Nr)
end

on SA Nr, varde
  global ObjektAktiv
  setAt(ObjektAktiv, Nr, varde)
end
