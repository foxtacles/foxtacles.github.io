on prepareMovie
  global InitVoice
  InitVoice = 1
end

on init
  global clSpikSpriteNum, cNumOfSwapKanaler, cNedslagenSpikMemberNum, lSpikObjMatris, cSwapToleransX, SpeletSlut, SpikarFrammeVidStart, SpeletIgang, AutoTimer, Poang, AjaBaja, cMaxAntalHit, cXMusTolerans, cYMusTolerans, gLatestHit, cCursorKanal, cStartCursorCast, cAntalCursorCast, cCursorTimeDelay, bAktivCursor, gCursorCastCounter, gLatestCursorChange, gAntalOmStartadeSpikar, cFartSlumpRange, cAccFactor, cHitLjudMemberNum, cDinkLjudMemberNum, HammareFunkar
  NollStallAutoTimer()
  SpeletSlut = 0
  SpikarFrammeVidStart = 0
  SpeletIgang = 0
  Poang = 0
  clSpikSpriteNum = list(28, 48, 68, 88)
  cNumOfSwapKanaler = 18
  cNedslagenSpikMemberNum = 62
  lSpikObjMatris = []
  cSwapToleransX = 10
  cMaxAntalHit = 3
  cXMusTolerans = 25
  cYMusTolerans = 40
  gLatestHit = 0
  cCursorKanal = 160
  cStartCursorCast = 46
  cAntalCursorCast = 3
  cCursorTimeDelay = 3
  bAktivCursor = 0
  gCursorCastCounter = 0
  gLatestCursorChange = 0
  gAntalOmStartadeSpikar = 0
  cFartSlumpRange = 3
  cAccFactor = 0.25
  cHitLjudMemberNum = 84
  cDinkLjudMemberNum = 82
  HammareFunkar = 1
  InitObjekt()
  InitPoangTomte(4, 121, 124, 3, 1)
  ShowPoangtomte(1)
  InitPoangLillTomte(5, 160, 3)
  ShowPoangLillTomte(0)
  ShowSparaFigur(1, 1)
  repeat with i = 0 to 18
    set the loc of sprite (10 + i) to point(-1000, -1000)
    set the loc of sprite (30 + i) to point(-1000, -1000)
    set the loc of sprite (50 + i) to point(-1000, -1000)
    set the loc of sprite (70 + i) to point(-1000, -1000)
  end repeat
  set the loc of sprite 120 to point(-1000, -1000)
  FixaFindusIntro()
end
