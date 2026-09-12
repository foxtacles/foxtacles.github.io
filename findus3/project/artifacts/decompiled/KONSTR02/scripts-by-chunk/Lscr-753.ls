on MakePettsonTalk Avsnitt
  global PettsonCastNr, UseDelay
  if Avsnitt = 0 then
    set the castNum of sprite 2 to PettsonCastNr
    exit
  end if
  put UseDelay
  puppetSprite(2, 1)
  repeat with i = 0 to 8
    set the castNum of sprite 2 to PettsonCastNr + i
    updateStage()
    if UseDelay = 1 then
      DelayHandler(10)
    end if
    if UseDelay = 0 then
      DelayHandler(3)
    end if
  end repeat
  if Avsnitt = 1 then
    puppetSound(member(195))
  end if
  if Avsnitt = 2 then
    puppetSound(member(196))
  end if
  updateStage()
  repeat while soundBusy(1) = 1
    set the castNum of sprite 2 to PettsonCastNr + 5 + random(3)
    if the mouseDown then
      puppetSound(0)
    end if
    updateStage()
    if the mouseDown then
      puppetSound(0)
    end if
    if UseDelay = 1 then
      DelayHandler(10)
    end if
    if UseDelay = 0 then
      DelayHandler(3)
    end if
    if the mouseDown then
      puppetSound(0)
    end if
  end repeat
  if Avsnitt <> 2 then
    puppetSprite(2, 1)
    repeat with i = 0 to 8
      set the castNum of sprite 2 to PettsonCastNr + 8 - i
      updateStage()
      if UseDelay = 1 then
        DelayHandler(10)
      end if
      if UseDelay = 0 then
        DelayHandler(3)
      end if
    end repeat
  end if
end
