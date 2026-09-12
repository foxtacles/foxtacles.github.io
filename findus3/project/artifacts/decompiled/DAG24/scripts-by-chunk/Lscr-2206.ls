on clear
  global showed
  repeat with n = 1 to count(showed)
    sprite(showed[n]).loc = point(-1000, -1000)
  end repeat
  showed = []
end
