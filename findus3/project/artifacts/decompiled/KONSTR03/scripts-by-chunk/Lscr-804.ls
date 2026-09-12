on exitFrame
  global NyAvsnitt, AktRitning
  if NyAvsnitt = 1 then
    go(1, "PINTRO")
  end if
  if (NyAvsnitt = 2) and (AktRitning > 0) then
    Kstr = string(AktRitning)
    if length(Kstr) = 1 then
      Kstr = "0" & Kstr
    end if
    Kstr = "KONSTR" & Kstr
    go(1, Kstr)
  end if
end
