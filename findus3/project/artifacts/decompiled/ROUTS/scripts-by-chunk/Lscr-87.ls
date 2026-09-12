on StartaUtLjud LjudSt
  global G_AktGame
  if G_AktGame = 2 then
    RensaLjud(4)
  else
    RensaLjud()
  end if
  puppetSound(1, LjudSt)
  repeat while the mouseDown = 1
  end repeat
  repeat while soundBusy(1) = 1
    if the mouseDown = 1 then
      puppetSound(1, 0)
    end if
  end repeat
  repeat while the mouseDown = 1
  end repeat
end
