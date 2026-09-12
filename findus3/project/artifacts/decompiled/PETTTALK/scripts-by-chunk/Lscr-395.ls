on TaFramBortPettson Avsnitt
  global PettsonPratat, AktRitning, PettSonFramme, AntalJaNejDjurggr, JaDjurSpriteNr, NejDjurSpriteNr, PettsonSpriteNr
  PettsCastNr = 10
  PettsLjudNr = 60
  puppetSprite(PettsonSpriteNr, 1)
  repeat while the mouseDown = 1
  end repeat
  if (Avsnitt = 1) or (Avsnitt = 4) or (Avsnitt = 5) or (Avsnitt = 6) then
    PettSonFramme = 1
    set the blend of sprite PettsonSpriteNr to 100
    repeat with i = 1 to 6
      set the castNum of sprite PettsonSpriteNr to member(PettsCastNr + i - 1, "PettTalk")
      updateStage()
      DelayPettson(5)
    end repeat
    if Avsnitt <> 5 then
      if (PettsonPratat = 0) or (Avsnitt = 4) then
        if Avsnitt = 1 then
          PettsonPratat = 1
          puppetSound(1, member(PettsLjudNr, "PettTalk"))
        end if
        if Avsnitt = 4 then
          puppetSound(1, member(PettsLjudNr + 34, "PettTalk"))
        end if
        if Avsnitt = 6 then
          puppetSound(1, member(PettsLjudNr + 32, "PettTalk"))
        end if
        updateStage()
        repeat while soundBusy(1) = 1
          set the castNum of sprite PettsonSpriteNr to member(PettsCastNr + 5 + random(3), "PettTalk")
          updateStage()
          startTimer()
          repeat while the timer < 10
            if the mouseDown = 1 then
              puppetSound(1, 0)
              exit repeat
            end if
          end repeat
        end repeat
      end if
    end if
    if Avsnitt = 6 then
    end if
    if (Avsnitt = 1) or (Avsnitt = 5) or (Avsnitt = 6) then
      repeat with i = 1 to 19
        set the castNum of sprite PettsonSpriteNr to member(PettsCastNr + 9 + i - 1, "PettTalk")
        updateStage()
        DelayPettson(5)
      end repeat
      set the castNum of sprite PettsonSpriteNr to member(PettsCastNr + 28 + AktRitning - 1, "PettTalk")
      puppetSound(1, member(PettsLjudNr + AktRitning, "PettTalk"))
      updateStage()
      AntalJaNejDjurggr = 0
    end if
    if Avsnitt = 4 then
      repeat with i = 1 to 6
        set the castNum of sprite PettsonSpriteNr to member(PettsCastNr + (6 - i) - 1, "PettTalk")
        updateStage()
        DelayPettson(5)
      end repeat
      PettSonFramme = 0
      set the blend of sprite PettsonSpriteNr to 0
    end if
  end if
  if Avsnitt = 2 then
    puppetSound(1, 0)
    AktRitning = AktRitning + 1
    if AktRitning > 3 then
      AktRitning = 1
    end if
    set the castNum of sprite PettsonSpriteNr to member(PettsCastNr + 28 + AktRitning - 1, "PettTalk")
    puppetSound(1, member(PettsLjudNr + AktRitning, "PettTalk"))
    updateStage()
    AntalJaNejDjurggr = 0
  end if
  if Avsnitt = 3 then
    PettSonFramme = 0
    set the blend of sprite JaDjurSpriteNr to 0
    set the blend of sprite NejDjurSpriteNr to 0
    puppetSound(1, 0)
    repeat with i = 1 to 27
      set the castNum of sprite PettsonSpriteNr to member(PettsCastNr + 27 - i - 1, "PettTalk")
      updateStage()
      DelayPettson(4)
      if i = 18 then
        i = 21
      end if
    end repeat
    set the blend of sprite PettsonSpriteNr to 0
    updateStage()
    AntalJaNejDjurggr = -1
    set the blend of sprite JaDjurSpriteNr to 0
    set the blend of sprite NejDjurSpriteNr to 0
  end if
end

on DelayPettson Timen
  startTimer()
  repeat while the timer < Timen
  end repeat
end
