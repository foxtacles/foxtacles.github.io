on KOllaKonstrukKnapp
  global PettSonFramme, AktRitning, NyAvsnitt
  if the mouseDown = 1 then
    Mx = the mouseH
    My = the mouseV
    Knapp = 0
    if (Mx > 144) and (Mx < 193) and (My > 13) and (My < 63) then
      Knapp = 2
    end if
    if (Mx > 565) and (Mx < 619) and (My > 14) and (My < 85) then
      Knapp = 3
    end if
    if Knapp > 0 then
      put Knapp
      if PettSonFramme then
        TaFramBortPettson(3)
      end if
      repeat while the mouseDown = 1
      end repeat
      if Knapp = 1 then
        repeat with i = 1 to 48
          puppetSprite(i, 0)
        end repeat
        go(1, "PINTRO")
      end if
      if Knapp = 2 then
        TaFramBortPettson(4)
      end if
      if Knapp = 3 then
        AktRitning = AktRitning + 1
        if AktRitning > 3 then
          AktRitning = 1
        end if
        TaFramBortPettson(5)
      end if
    end if
  end if
end
