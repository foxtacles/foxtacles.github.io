global gGameTime

on mouseUp
  cursor(4)
  puppetSound(1, 34)
  shuffle(100)
  repeat while check_completed()
    puppetSound(1, 34)
    shuffle(100)
  end repeat
  render_game()
  set the timer to 0
  gGameTime = -1
  unloadMember()
  go("gameloop")
end
