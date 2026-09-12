on exitFrame
  puppetSound("start")
  if soundBusy(1) then
    go(the frame)
  end if
  set the volume of sound 2 to 100
  go("gameloop")
end
