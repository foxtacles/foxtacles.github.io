on exitFrame
  global BildTimer, Bildggr, blendTimer, BlendSprite
  if (the timer > BildTimer) and (Bildggr > 0) then
    BildTimer = the timer + 100
    blendTimer = the timer + 10
    BlendSprite = 7
    sprite(BlendSprite).blend = 0
    set the loc of sprite 7 to point(364, 333)
    Bildggr = 0
  end if
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
      updateStage()
    end if
  end if
  if soundBusy(1) = 0 then
    go(the frame + 1)
  else
    go(the frame)
  end if
end
