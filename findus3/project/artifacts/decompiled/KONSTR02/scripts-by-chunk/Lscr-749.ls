on mus SpriteNr
  global OnOff, XposV, YposV, XPosS, yPosS, PettSonFramme
  if PettSonFramme then
    TaFramBortPettson(3)
  end if
  if OnOff = 0 then
    ChangeToStage(SpriteNr)
    repeat while the mouseDown
      set the locH of sprite SpriteNr to the mouseH
      set the locV of sprite SpriteNr to the mouseV
      updateStage()
    end repeat
    KOLLAKOORDINATER(SpriteNr)
  end if
end
