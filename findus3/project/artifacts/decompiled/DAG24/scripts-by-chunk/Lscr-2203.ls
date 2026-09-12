on test p, V
  n = []
  repeat with m = 1 to count(V)
    append(n, V[m] - p)
  end repeat
  return n
end
