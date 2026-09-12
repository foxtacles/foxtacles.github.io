on HUVUDLOOP
  global SlutForObjekt, StartTidForObjekt, AntalggrObjekt, AntalggrCounter, AntalLoopObjekt, LoopCounter, StartXPos, StartYPos, OknY, OknX, ObjektAktiv, StartbildObjekt, AntalObjekt, BildTidForObjekt, BildTidCounter, spriteNum, OknBild, AntalggrEfterLoop, StartbildEfterLoop, EndOfMovie, ObjektSound, KonstruktionFardig, SenasteLoopFrame, OknBildCounter, StartbildObjekt2, UseDelay, Oknggr, LoopTyp, FrameNr, SlutLjud, SenasteLjud
  SenasteLjud = 0
  KonstruktionFardig = 0
  if GA(2) > 0 then
    setAt(Oknggr, 1, 3)
  end if
  if GA(2) = 0 then
    setAt(Oknggr, 1, 1)
  end if
  if (GA(2) > 0) and (GA(4) > 0) and (GA(8) > 0) then
    setAt(AntalLoopObjekt, 10, 2)
    KonstruktionFardig = 1
  else
    setAt(AntalLoopObjekt, 10, 1)
  end if
  EndKonstrukt = 0
  FrameNr = 0
  GrundTick = the ticks
  repeat while EndKonstrukt = 0
    if the mouseUp = 0 then
      EndKonstrukt = 1
    end if
    GrundTick = the ticks
    FrameNr = FrameNr + 1
    startTimer()
    repeat with ObjNum = 1 to AntalObjekt
      SpriteNr = getaProp(spriteNum, ObjNum)
      ObjStartTid = getAt(StartTidForObjekt, ObjNum)
      SenastFrame = getAt(SenasteLoopFrame, ObjNum)
      SpecialCheckForKonstruk3(ObjNum)
      ObjAktiv = getAt(ObjektAktiv, ObjNum)
      if (FrameNr = ObjStartTid) and ((ObjAktiv = 1) or (ObjAktiv = 2)) then
        sprite(SpriteNr).visible = 1
        setAt(ObjektAktiv, ObjNum, 3)
        set the castNum of sprite SpriteNr to getaProp(StartbildObjekt2, ObjNum)
        if getAt(ObjektSound, ObjNum) > 0 then
          puppetSound(cast(getAt(ObjektSound, ObjNum)))
          SenasteLjud = ObjNum
        end if
      end if
      LoopResultat = 0
      if ObjAktiv = 3 then
        SpriteNr = getaProp(spriteNum, ObjNum)
        setAt(OknBildCounter, ObjNum, getAt(OknBildCounter, ObjNum) + 1)
        if getAt(OknBildCounter, ObjNum) > getAt(Oknggr, ObjNum) then
          LoopResultat = 1
          setAt(OknBildCounter, ObjNum, 0)
          setAt(AntalggrCounter, ObjNum, getaProp(AntalggrCounter, ObjNum) + 1)
          if getAt(LoopCounter, ObjNum) > 0 then
            KollaMedggr = getAt(AntalggrEfterLoop, ObjNum)
          end if
          if getAt(LoopCounter, ObjNum) = 0 then
            KollaMedggr = getAt(AntalggrObjekt, ObjNum)
          end if
          if getAt(AntalggrCounter, ObjNum) >= KollaMedggr then
            setAt(LoopCounter, ObjNum, getaProp(LoopCounter, ObjNum) + 1)
            if getAt(LoopCounter, ObjNum) >= getAt(AntalLoopObjekt, ObjNum) then
              LoopResultat = 3
              if getaProp(SlutForObjekt, ObjNum) = 0 then
                LoopResultat = 4
              end if
            else
              LoopResultat = 5
            end if
          end if
          if LoopResultat = 1 then
            if getAt(OknBild, ObjNum) > 0 then
              CastNR = the castNum of sprite SpriteNr
              CastNR = CastNR + getAt(OknBild, ObjNum)
              set the castNum of sprite SpriteNr to CastNR
            end if
            set the locH of sprite SpriteNr to the locH of sprite SpriteNr + getaProp(OknX, ObjNum)
            set the locV of sprite SpriteNr to the locV of sprite SpriteNr + getaProp(OknY, ObjNum)
          end if
          if LoopResultat = 3 then
            setAt(ObjektAktiv, ObjNum, 4)
            if (getAt(SlutLjud, ObjNum) = -1) and (SenasteLjud = ObjNum) then
              puppetSound(0)
            end if
          end if
          if LoopResultat = 4 then
            sprite(getaProp(spriteNum, ObjNum)).visible = 0
            setAt(ObjektAktiv, ObjNum, 4)
            if (getAt(SlutLjud, ObjNum) = -1) and (SenasteLjud = ObjNum) then
              puppetSound(0)
            end if
          end if
          if LoopResultat = 5 then
            setAt(AntalggrCounter, ObjNum, 0)
            set the castNum of sprite getaProp(spriteNum, ObjNum) to getaProp(StartbildEfterLoop, ObjNum)
            SpriteNr = getaProp(spriteNum, ObjNum)
            if getAt(LoopTyp, ObjNum) = 2 then
              set the locH of sprite SpriteNr to the locH of sprite SpriteNr + getaProp(OknX, ObjNum)
              set the locV of sprite SpriteNr to the locV of sprite SpriteNr + getaProp(OknY, ObjNum)
              next repeat
            end if
            set the locH of sprite SpriteNr to getaProp(StartXPos, ObjNum)
            set the locV of sprite SpriteNr to getaProp(StartYPos, ObjNum)
          end if
        end if
      end if
    end repeat
    updateStage()
    startTimer()
    repeat while the timer < 2
      nothing()
    end repeat
    UseDelay = 1
    if FrameNr > EndOfMovie then
      EndKonstrukt = 1
    end if
  end repeat
  RESETCOUNTERS()
end
