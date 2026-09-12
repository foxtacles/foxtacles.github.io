global nystart, tillbaka

on exitFrame
  global ljudlista, randomlista, anvlista, anvtries
  nystart = 0
  tillbaka = 0
  unloadMember()
  if nystart = 1 then
    go("init")
    exit
  else
    if tillbaka = 1 then
      puppetSprite(12, 0)
      puppetTransition(10)
      go("vidare")
      exit
    end if
  end if
  case random(3) of
    1:
      ljudlista = ["1.aif", "2.aif", "3.aif", "4.aif", "5.aif"]
    2:
      ljudlista = ["11.aif", "12.aif", "13.aif", "14.aif", "15.aif"]
    3:
      ljudlista = ["21.aif", "22.aif", "23.aif", "24.aif", "25.aif"]
  end case
  randomlista = makerlist(ljudlista, 3)
  anvlista = []
  anvtries = 0
  playsong(randomlista)
  puppetSound("start")
  set the visible of sprite 24 to 0
  repeat with k = 3 to 5
    set the visible of sprite k to 1
  end repeat
  repeat with k = 7 to 9
    set the visible of sprite k to 0
  end repeat
  updateStage()
  cursor(0)
  go(the frame + 1)
end
