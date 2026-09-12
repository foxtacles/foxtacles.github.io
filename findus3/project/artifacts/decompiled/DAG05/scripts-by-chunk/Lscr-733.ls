on setRegPoint startM, stopM
  X = 125
  Y = -15
  repeat with m = startM to stopM
    temp = member(m).regPoint
    t1 = getAt(temp, 1)
    t2 = getAt(temp, 2)
    member(m).regPoint = point(t1 + X, t2 + Y)
  end repeat
end
