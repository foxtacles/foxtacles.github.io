global honIntervall, tid, klubba, tupp, level, ax, plats, posH, posV

on honTest
  stopp = the ticks
  plats = random(12)
  puppetSprite(10, 1)
  if plats = 12 then
    plats = 13
  end if
  set the memberNum of sprite 10 to member(plats & "anim_3", "honor")
  set the visible of sprite 10 to 1
  puppetSound("chicken" & random(2))
  honplats = the memberNum of sprite 10
  repeat while the memberNum of sprite 10 > (honplats - 2)
    updateStage()
    set the memberNum of sprite 10 to the memberNum of sprite 10 - 1
    klubbmus()
    ove = the ticks
    repeat while the ticks < (ove + 6)
      klubbmus()
    end repeat
  end repeat
  repeat while the ticks < (stopp + level - (honIntervall * ax))
    set the locH of sprite 61 to the locH of sprite 60
    set the locV of sprite 61 to the locV of sprite 60
    klubbmus()
    if rollOver(3) or rollOver(4) then
      exit
    end if
    if the mouseDown then
      set the memberNum of sprite 60 to the memberNum of sprite 60 + 1
      posH = the locH of sprite 60
      posV = the locV of sprite 60
      snoboll()
      set the memberNum of sprite 60 to the memberNum of sprite 60 - 1
      updateStage()
      if sprite 61 intersects sprite(10) then
        set the visible of sprite 10 to 0
        puppetSound("hit.aif")
        updateStage()
        honIntervall = honIntervall + 1
        klubba = klubba + 1
        set the visible of sprite klubba to 1
        updateStage()
        if klubba = 49 then
          go("vinst")
        end if
        tid = the ticks
        exit
      else
        puppetSound("miss.aif")
        tupp = tupp + 1
        set the visible of sprite 10 to 0
        set the visible of sprite tupp to 1
        eggkast()
        if tupp = 42 then
          go("forlust")
        end if
      end if
      tid = the ticks
      exit
    end if
    updateStage()
  end repeat
  repeat while the memberNum of sprite 10 < honplats
    updateStage()
    set the memberNum of sprite 10 to the memberNum of sprite 10 + 1
    klubbmus()
    ove = the ticks
    repeat while the ticks < (ove + 3)
      klubbmus()
    end repeat
  end repeat
  set the visible of sprite 10 to 0
  tupp = tupp + 1
  set the visible of sprite tupp to 1
  eggkast()
  if tupp = 42 then
    go("forlust")
  end if
  tid = the ticks
end
