on Pointinpoly p, V, X, Y
  flag = 0
  V = V + V
  j = V - 1
  repeat with i = 1 to V
    ka = (p[i + 1] <= Y) and (Y < p[j + 1])
    kb = (p[j + 1] <= Y) and (Y < p[i + 1])
    kc = X < ((float((p[j] - p[i]) * (Y - p[i + 1])) / float(p[j + 1] - p[i + 1])) + p[i])
    j = i
    i = i + 1
    if (ka or kb) and kc then
      flag = not flag
    end if
  end repeat
  return flag
end
