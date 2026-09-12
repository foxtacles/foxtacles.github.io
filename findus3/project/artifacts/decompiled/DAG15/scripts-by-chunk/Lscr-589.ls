on mouseUp
  global dra, vatt
  puppetSprite(9, 1)
  set the castNum of sprite 9 to 18
  put field("p") - 1 into field "p"
  dra = 1
  vatt = [1, 1, 1]
end
