on exitFrame
  global OkAttAvsluta
  OkAttAvsluta = 1
  set the volume of sound 2 to 255
  puppetTransition(9)
  puppetSound("rim")
  go(2)
end
