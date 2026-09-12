on KOLLAKOORDINATER SpriteNr
  global AntalVerktygsObjekt, spriteNum, StartXPos, StartYPos, AntalObjekt, XposV, YposV, BildIVerktygsLada, ObjektAktivProfil, ObjektAktiv, IntroSound, AntalggrObjekt, SlutForObjekt, StartbildEfterLoop, StartbildObjekt, AntalLoopObjekt, AntalggrEfterLoop, StartbildObjekt2
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
  if GA(3) > 0 then
    if GA(2) > 0 then
      SA(3, 1)
    else
      SA(3, 4)
    end if
  end if
  if GA(4) > 0 then
    if (GA(3) > 0) and (GA(5) > 0) then
      if GA(2) > 0 then
        SA(4, 1)
      else
        SA(4, 4)
      end if
    else
      SA(4, 0)
    end if
  end if
  if GA(5) > 0 then
    if (GA(4) > 0) and (GA(2) > 0) then
      SA(5, 1)
    else
      SA(5, 4)
    end if
  end if
  if (GA(5) = 1) and (GA(6) = 0) then
    SA(11, 2)
  else
    SA(11, 0)
  end if
  if (GA(5) = 1) and (GA(6) > 0) and (GA(7) = 0) then
    SA(12, 2)
  else
    SA(12, 0)
  end if
  if (GA(5) = 0) and (GA(6) > 0) then
    SA(6, 0)
  end if
  if (GA(7) > 0) and (GA(6) = 0) then
    SA(7, 0)
  end if
  if (GA(8) > 0) and (GA(7) = 0) then
    SA(8, 0)
  end if
  if (GA(5) = 1) and (GA(7) > 0) and (GA(8) = 0) then
    SA(13, 2)
  else
    SA(13, 0)
  end if
  if (GA(5) = 1) and (GA(8) > 0) then
    SA(9, 2)
  else
    SA(9, 0)
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
