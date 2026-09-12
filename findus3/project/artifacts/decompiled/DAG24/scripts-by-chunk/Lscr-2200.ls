on bildspelsloop
  global blendTimer, BlendSprite
  hanteraavsnitt()
  if the timer > blendTimer then
    blendTimer = the timer + 10
    if BlendSprite > 0 then
      b = sprite(BlendSprite).blend
      b = b + 10
      if b > 100 then
        b = 100
      end if
      sprite(BlendSprite).blend = b
      if b = 100 then
        BlendSprite = 0
      end if
    end if
  end if
end
