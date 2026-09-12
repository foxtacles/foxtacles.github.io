on exitFrame
  puppetSprite(18, 1)
  puppetSprite(19, 1)
  repeat with i = 1 to 15
    set the castNum of sprite 18 to 450 + i - 1
    if i > 10 then
      set the castNum of sprite 19 to 470 + i - 11
      put 470 + i - 9
    end if
    updateStage()
    DelayHandler(15)
    put i
  end repeat
  DelayHandler(100)
  go(the frame)
end
