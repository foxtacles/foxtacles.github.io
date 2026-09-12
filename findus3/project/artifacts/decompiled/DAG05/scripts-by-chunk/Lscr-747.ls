on exitFrame
  global lSpikObjMatris, AutoLage, SpeletSlut, AktivAutoSpik, SpeletIgang, SpikarFrammeVidStart, InitVoice, AutoTimer, cCursorKanal, HammareFunkar
  FrameTid = the timer
  if SpeletSlut = 1 then
    FixaRedovisning()
  else
    Ngn = 0
    repeat with i = 1 to 4
      if lSpikObjMatris[i].xPos > 400 then
        Ngn = 1
      end if
    end repeat
    if Ngn = 1 then
      sprite(3).member = member(23, "Graphics")
    else
      sprite(3).member = member(22, "Graphics")
    end if
    if SpikarFrammeVidStart = 0 then
      HammareFunkar = 1
      repeat with i = 1 to 4
        animera(getAt(lSpikObjMatris, i))
        AnimeraCursor()
      end repeat
    end if
    if (SpikarFrammeVidStart = 1) and (SpeletIgang = 0) and (the mouseDown = 1) then
      ShowPoangtomte(0)
      SpeletIgang = 1
      HammareFunkar = 2
      INCPoang(0)
      repeat with i = 1 to 4
        getAt(lSpikObjMatris, i).status = 2
      end repeat
    end if
    if SpeletIgang = 1 then
      repeat with i = 1 to 4
        animera(getAt(lSpikObjMatris, i))
        AnimeraCursor()
      end repeat
    end if
    repeat while the timer < (FrameTid + 3)
      if HammareFunkar > 0 then
        if (the mouseV > 75) and (the mouseV < 340) then
          cursor(200)
          set the loc of sprite cCursorKanal to the mouseLoc
        else
          cursor(-1)
          set the loc of sprite cCursorKanal to point(-1000, -1000)
        end if
      end if
      updateStage()
    end repeat
  end if
  go(the frame)
end
