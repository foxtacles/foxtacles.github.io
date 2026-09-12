on exitFrame
  global flash, FirstTime, G_SpikFirstTime
  flash = 0
  FirstTime = 1
  set the volume of sound 2 to 255
  puppetTransition(9)
  puppetSound("rim")
  G_SpikFirstTime = 1
end
