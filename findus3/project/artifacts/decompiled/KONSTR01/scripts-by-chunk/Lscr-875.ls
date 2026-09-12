on KOLLAKOORDINATER SpriteNr
  global AntalVerktygsObjekt, spriteNum, StartXPos, StartYPos, AntalObjekt, XposV, YposV, BildIVerktygsLada, ObjektAktivProfil, ObjektAktiv, IntroSound
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
  if (GA(3) > 0) and (GA(4) = 0) then
    SA(3, 0)
  end if
  if (GA(4) > 0) and (GA(3) = 0) then
    SA(4, 4)
  end if
  if (GA(4) > 0) and (GA(3) > 0) then
    SA(4, 1)
  end if
  if GA(4) = 1 then
    SA(1, 1)
    SA(6, 1)
    SA(1, 1)
    SA(5, 1)
  else
    SA(1, 4)
    SA(6, 4)
    SA(1, 4)
    SA(5, 4)
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
