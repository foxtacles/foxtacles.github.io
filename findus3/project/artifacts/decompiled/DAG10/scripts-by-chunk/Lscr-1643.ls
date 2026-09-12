property ObjectNr, SpriteNr, PixelPerSteg, BytBildVidSteg, AnimVinklar, aktivAction, Animation_bilder, FrameTime, CastName, CastIntervall, StartcastNr, SlutcastNr, picsPerAngle, standSequens, soundSequens, aktiv, Talande, AktAvsnitt, AktReplikNr, Node, PathList, posX, posY, AktBild, DraOK, onScreen, DragBild, m

on new me
  ObjectNr = 0
  SpriteNr = 0
  PixelPerSteg = 0
  BytBildVidSteg = 0
  AnimVinklar = 0
  aktivAction = 0
  Animation_bilder = []
  FrameTime = []
  CastName = 0
  CastIntervall = []
  StartcastNr = []
  SlutcastNr = []
  picsPerAngle = []
  standSequens = []
  soundSequens = []
  aktiv = 0
  Talande = 0
  AktAvsnitt = 0
  AktReplikNr = 0
  Node = 0
  PathList = 0
  posX = 0
  posY = 0
  AktBild = 0
  DraOK = 0
  onScreen = 0
  DragBild = 0
  m = 3
  return me
end

on initSveaObject me, obNr, sprNr, pixels, bytBild, vinklar
  ObjectNr = obNr
  SpriteNr = sprNr
  PixelPerSteg = pixels
  BytBildVidSteg = bytBild
  AnimVinklar = vinklar
end

on initSveaObjectPosition me, X, Y, Bild, cast
  posY = Y
  posX = X
  AktBild = Bild
  CastName = cast
end

on initSveaObjectAnimation me, intervall, start, stop, pixPerANgle, animationPix, times
  CastIntervall = intervall
  StartcastNr = start
  SlutcastNr = stop
  picsPerAngle = pixPerANgle
  Animation_bilder = animationPix
  FrameTime = times
end

on initSveaObjectFlags me, drag, Onscrn, dragPic
  DraOK = drag
  onScreen = Onscrn
  DragBild = dragPic
end

on initSveaObjectNode me, theNode
  Node = theNode
end
