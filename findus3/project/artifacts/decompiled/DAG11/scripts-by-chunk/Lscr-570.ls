global ordningslist, w, aktivPlats, aktivSprite

on goNext
  aktivSprite = getAt(ordningslist, random(w))
  set the visible of sprite aktivSprite to 1
  set the moveableSprite of sprite aktivSprite to 1
  deleteOne(ordningslist, aktivSprite)
  w = w - 1
  aktivPlats = aktivSprite - 11
end
