on nolla_curs first, last
  repeat with X = first to last
    set the cursor of sprite X to 0
  end repeat
end

on puppets_off first, last
  repeat with X = first to last
    puppetSprite(X, 0)
  end repeat
end

on puppets_on first, last
  repeat with X = first to last
    puppetSprite(X, 1)
  end repeat
end

on visible_on first, last
  repeat with X = first to last
    set the visible of sprite X to 1
  end repeat
end

on visible_off first, last
  repeat with X = first to last
    set the visible of sprite X to 0
  end repeat
end
