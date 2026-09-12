global stanna, b, s

on exitFrame
  repeat with s = 1 to 3
    puppetSound(2, "TOMTE_" & b & "_" & s)
    put "l", "TOMTE_" & b & "_" & s
    repeat while soundBusy(2)
      mustest()
      updateStage()
    end repeat
    if s = 4 then
      exit repeat
    end if
    unloadMember(member("TOMTE_" & b & "_" & s))
  end repeat
  sprite(14).visible = 1
  sprite(8).visible = 0
  if stanna = 1 then
    go(the frame)
  else
    if b = 6 then
      go(#next)
    else
      b = b + 1
      go(#next)
    end if
  end if
end
