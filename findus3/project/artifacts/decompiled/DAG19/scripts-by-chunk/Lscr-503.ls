on mouseUp
  global anvlista, randomlista, ljudlista, anvtries
  cursor(0)
  add(anvlista, the clickOn)
  if checksong() then
    set the visible of sprite (getAt(anvlista, count(anvlista)) + 4) to 1
    set the visible of sprite getAt(anvlista, count(anvlista)) to 0
    puppetSound(getAt(ljudlista, count(anvlista)))
    updateStage()
    repeat while soundBusy(1)
      nothing()
    end repeat
    set the visible of sprite getAt(anvlista, count(anvlista)) to 1
    set the visible of sprite (getAt(anvlista, count(anvlista)) + 4) to 0
    if count(anvlista) = count(randomlista) then
      cursor(0)
      puppetSound("done" & random(4))
      updateStage()
      repeat while soundBusy(1)
        nothing()
      end repeat
      go("klarat")
    end if
  else
    set the visible of sprite (getAt(anvlista, count(anvlista)) + 4) to 1
    set the visible of sprite getAt(anvlista, count(anvlista)) to 0
    set the memberNum of sprite 12 to the memberNum of sprite 12 - 1
    puppetSound("wrong")
    updateStage()
    repeat while soundBusy(1)
      nothing()
    end repeat
    set the visible of sprite getAt(anvlista, count(anvlista)) to 1
    set the visible of sprite (getAt(anvlista, count(anvlista)) + 4) to 0
    deleteAt(anvlista, count(anvlista))
    anvtries = anvtries + 1
    if anvtries = 3 then
      puppetSound("fel" & random(2))
      go("missat")
    else
    end if
  end if
end
