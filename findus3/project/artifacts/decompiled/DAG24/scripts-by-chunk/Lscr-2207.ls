on show BAvsnit
  global BlendSprite, positions, showed
  BlendSprite = BAvsnit[1]
  if BAvsnit[4] = 1 then
    sprite(BAvsnit[1]).blend = 0
  else
    sprite(BAvsnit[1]).blend = 100
  end if
  sprite(BAvsnit[1]).loc = BAvsnit[2]
  append(showed, BAvsnit[1])
end
