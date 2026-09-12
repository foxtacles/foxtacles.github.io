on SpecialCheckForKonstruk3 ObjNum
  global SlutForObjekt, StartTidForObjekt, AntalggrObjekt, AntalggrCounter, AntalLoopObjekt, LoopCounter, StartXPos, StartYPos, OknY, OknX, ObjektAktiv, StartbildObjekt, BildTidForObjekt, BildTidCounter, spriteNum, OknBild, AntalggrEfterLoop, StartbildEfterLoop, XposV, YposV, VerktygsObjekt, BildIVerktygsLada, AntalVerktygsObjekt, ObjektAktivProfil, EndOfMovie, ObjektSound, AntalObjekt, SenasteLoopFrame, OknBildCounter, StartbildObjekt2, Oknggr, FrameNr, SmaDjurIsJumping, SmaDjur1Sprite, SmaDjur2Sprite, LoopTyp
  if FrameNr = 175 then
    if (GA(2) > 0) and (GA(3) > 0) and (GA(4) > 0) and (GA(5) > 0) and (GA(6) > 0) and (GA(7) > 0) and (GA(8) > 0) and (soundBusy(1) = 0) then
      puppetSound(member(719))
      updateStage()
    end if
  end if
end
