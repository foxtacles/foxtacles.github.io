global gSoundCount

on checkSound
  if not soundBusy(1) then
    unloadMember(131, 149)
    puppetSound("dans_ljud" & gSoundCount)
    gSoundCount = gSoundCount + 1
    if gSoundCount > 9 then
      gSoundCount = 1
    end if
  end if
end
