on PlaceraUtObjekt
  global XPosS, ObjektAktiv, VerktygsObjekt, spriteNum, BildIVerktygsLada, StartbildObjekt, AntalVerktygsObjekt, XposV, YposV, StartXPos, StartYPos
  repeat with ObjNum = 1 to AntalVerktygsObjekt
    SpritNr = getaProp(spriteNum, ObjNum)
    if ObjNum = 10 then
      ObjNum = ObjNum
    end if
    if SpritNr > 0 then
      puppetSprite(SpritNr, 1)
      if getaProp(ObjektAktiv, ObjNum) = 0 then
        if getaProp(VerktygsObjekt, ObjNum) = 0 then
          set the visible of sprite SpritNr to 0
        else
          set the visible of sprite SpritNr to 1
          set the castNum of sprite SpritNr to getaProp(BildIVerktygsLada, ObjNum)
          set the locH of sprite SpritNr to getaProp(XposV, ObjNum)
          set the locV of sprite SpritNr to getaProp(YposV, ObjNum)
        end if
      end if
      if (getaProp(ObjektAktiv, ObjNum) = 1) or (getaProp(ObjektAktiv, ObjNum) = 4) then
        set the visible of sprite SpritNr to 1
        set the castNum of sprite SpritNr to getaProp(StartbildObjekt, ObjNum)
        set the locH of sprite SpritNr to getaProp(StartXPos, ObjNum)
        set the locV of sprite SpritNr to getaProp(StartYPos, ObjNum)
      end if
      if getaProp(ObjektAktiv, ObjNum) = 2 then
        set the visible of sprite SpritNr to 0
        set the castNum of sprite SpritNr to getaProp(StartbildObjekt, ObjNum)
        set the locH of sprite SpritNr to getaProp(StartXPos, ObjNum)
        set the locV of sprite SpritNr to getaProp(StartYPos, ObjNum)
      end if
      if getaProp(ObjektAktiv, ObjNum) = 5 then
        set the visible of sprite SpritNr to 0
      end if
    end if
  end repeat
  repeat with ObjNum = 1 to AntalVerktygsObjekt
    SpritNr = getaProp(spriteNum, ObjNum)
    set the blend of sprite SpritNr to 100
  end repeat
end
