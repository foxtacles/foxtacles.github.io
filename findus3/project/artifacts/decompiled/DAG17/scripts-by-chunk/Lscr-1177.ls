on mouseWithin me
  thisSprite = me.spriteNum
  set the loc of sprite 52 to the loc of sprite thisSprite
end

on mouseLeave
  set the loc of sprite 52 to point(-1000, -1000)
end

on mouseUp me
  global gameStage, numberOfPlayers
  thisSprite = me.spriteNum
  numberOfPlayers = 1
  gameStage = 2
  repeat with j = 49 to 83
    set the loc of sprite j to point(-1000, -1000)
  end repeat
end
