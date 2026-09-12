on exitFrame
  repeat with kan = 3 to 23
    set the visible of sprite kan to 0
  end repeat
  updateStage()
  set the visible of sprite 12 to 1
  volym = the volume of sound 2
  repeat while volym < 100
    volym = volym + 10
    set the volume of sound 2 to integer(volym)
    Wait(6)
  end repeat
  puppetTransition(9)
  puppetSound("rim")
  go("dikt")
end
