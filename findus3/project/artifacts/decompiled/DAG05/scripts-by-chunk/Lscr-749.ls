property status, Kanal, xPos, yPos, XstegLista, YstegLista, XStopLista, CastCounterLista, StartCastLista, TotalAntalCastLista, LatestTimeCastChangedLista, DelayTimeBetweenCastLista, AntalNedslag, AntalSpikarNedslagna, cDinkLjudMemberNum

on new me, stat, channal, X, Y, xStepL, yStepL, xHaltL, ccL, scL, tacL, ltccL, dtbcL
  status = stat
  Kanal = channal
  xPos = 20
  yPos = 200
  XstegLista = xStepL
  YstegLista = yStepL
  XStopLista = xHaltL
  CastCounterLista = ccL
  StartCastLista = scL
  TotalAntalCastLista = tacL
  LatestTimeCastChangedLista = ltccL
  DelayTimeBetweenCastLista = dtbcL
  AntalNedslag = 0
  AntalSpikarNedslagna = 0
  set the loc of sprite Kanal to point(xPos, yPos)
  set the memberNum of sprite Kanal to getAt(StartCastLista, status) + 1
  return me
end

on animera me
  global HammareFunkar, SpeletSlut, SpikarFrammeVidStart, SpeletIgang
  if status < 0 then
    status = status + 10
  end if
  case status of
    1:
      xPos = xPos + getAt(XstegLista, 1)
      yPos = yPos + getAt(YstegLista, 1)
      if xPos >= getAt(XStopLista, 1) then
        status = 2
        SpikarFrammeVidStart = 1
        set the memberNum of sprite Kanal to getAt(StartCastLista, 2) + 1
        exit
      end if
      set the loc of sprite Kanal to point(xPos, yPos)
      if getAt(LatestTimeCastChangedLista, 1) < the ticks then
        setAt(LatestTimeCastChangedLista, 1, the ticks + getAt(DelayTimeBetweenCastLista, 1))
        temp = getAt(CastCounterLista, 1) + 1
        if temp > getAt(TotalAntalCastLista, 1) then
          temp = 1
        end if
        setAt(CastCounterLista, 1, temp)
        set the memberNum of sprite Kanal to getAt(StartCastLista, 1) + getAt(CastCounterLista, 1)
      end if
    2:
      if getAt(CastCounterLista, 2) > 2 then
        xPos = xPos + getAt(XstegLista, 2)
      end if
      if (xPos > (getAt(XStopLista, 2) - 40)) and (HammareFunkar > 0) then
        HammareFunkar = 0
        puppetSound(2, member(86 + random(4) - 1))
      end if
      if xPos > getAt(XStopLista, 2) then
        SpeletSlut = 1
      end if
      if getAt(LatestTimeCastChangedLista, 2) < the ticks then
        if getAt(CastCounterLista, 2) <> 3 then
          setAt(LatestTimeCastChangedLista, 2, the ticks + getAt(DelayTimeBetweenCastLista, 2))
        else
          setAt(LatestTimeCastChangedLista, 2, the ticks + (3.5 * getAt(DelayTimeBetweenCastLista, 2)))
        end if
        temp = getAt(CastCounterLista, 2) + 1
        if temp > getAt(TotalAntalCastLista, 2) then
          temp = 1
        end if
        setAt(CastCounterLista, 2, temp)
        set the memberNum of sprite Kanal to getAt(StartCastLista, 2) + getAt(CastCounterLista, 2)
      end if
      set the loc of sprite Kanal to point(xPos, yPos)
    3:
      if getAt(LatestTimeCastChangedLista, status) < the ticks then
        AntalNedslag = AntalNedslag - 1
        if AntalNedslag < 0 then
          AntalNedslag = 0
          status = 2
          setAt(CastCounterLista, 2, 0)
          exit
        end if
        set the memberNum of sprite Kanal to getAt(StartCastLista, 3) + AntalNedslag
        setAt(LatestTimeCastChangedLista, status, the ticks + getAt(DelayTimeBetweenCastLista, status))
      end if
  end case
end

on getAntalNedslag me
  return AntalNedslag
end

on SetSpikBeingHit me
  if status > 1 then
    status = status + 10
  end if
end

on Hit me
  global cMaxAntalHit, cNumOfSwapKanaler, cHitLjudMemberNum, cNedslagenSpikMemberNum, gLatestHit, gAntalOmStartadeSpikar, cFartSlumpRange, cAccFactor, cDinkLjudMemberNum
  gLatestHit = 0
  puppetSound(1, member(cHitLjudMemberNum))
  if status > 1 then
    status = status - 10
  end if
  if status = 1 then
    exit
  end if
  if status = 2 then
    IsObjOverOldSpik(Kanal, AntalSpikarNedslagna)
    if the result = 1 then
      exit
    else
      status = 3
    end if
  end if
  AntalNedslag = AntalNedslag + 1
  if AntalNedslag <= cMaxAntalHit then
    puppetSound(1, 82)
  else
    puppetSound(1, 85)
  end if
  if AntalNedslag > cMaxAntalHit then
    INCPoang(1)
    AntalSpikarNedslagna = AntalSpikarNedslagna + 1
    if AntalSpikarNedslagna > cNumOfSwapKanaler then
      alert("Max antal swapkanaler")
    end if
    set the loc of sprite (Kanal - AntalSpikarNedslagna) to the loc of sprite Kanal
    set the memberNum of sprite (Kanal - AntalSpikarNedslagna) to cNedslagenSpikMemberNum
    status = 1
    gAntalOmStartadeSpikar = gAntalOmStartadeSpikar + 1
    thisFart = random(cFartSlumpRange) + (float(gAntalOmStartadeSpikar) * float(cAccFactor))
    setAt(XstegLista, 2, thisFart)
    xPos = 20
    yPos = 200
    CastCounterLista = [0, 0]
    LatestTimeCastChangedLista = [0, 0, 0]
    AntalNedslag = 0
    set the loc of sprite Kanal to point(xPos, yPos)
    exit
  end if
  set the memberNum of sprite Kanal to getAt(StartCastLista, 4) + AntalNedslag
  setAt(LatestTimeCastChangedLista, 3, the ticks + getAt(DelayTimeBetweenCastLista, 3))
end
