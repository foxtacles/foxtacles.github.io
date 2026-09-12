on mouseUp
  global numberOfPlayers, ballALive
  if ballALive = 1 then
    return 
  end if
  if the mouseLoc > (sprite(the clickOn).left + (sprite(the clickOn).width / 2)) then
    initvar()
    numberOfPlayers = 2
    FixaFindusIntro(2)
  else
    initvar()
    numberOfPlayers = 1
    FixaFindusIntro(1)
  end if
end
