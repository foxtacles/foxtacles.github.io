global gTileSprite, gTileCast

on exitFrame
  gTileSprite = 10
  gTileCast = 45
  clear_tiles()
  init_game(3, 100, 10, 73, 289, 82)
  set the visible of sprite 8 to 0
  set the visible of sprite 9 to 0
  put EMPTY into field "time_field"
end
