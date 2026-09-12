on exitFrame
  global flash, FirstTime
  flash = 0
  FirstTime = 1
  set the volume of sound 2 to 255
  puppetTransition(9)
  puppetSound("rim")
end
