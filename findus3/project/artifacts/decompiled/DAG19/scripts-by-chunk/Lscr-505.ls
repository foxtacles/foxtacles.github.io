on makerlist inlist, antalf
  outlist = []
  repeat with X = 1 to count(inlist)
    putit = random(antalf) + 2
    if count(outlist) > 0 then
      repeat while putit = getAt(outlist, X - 1)
        putit = random(antalf) + 2
      end repeat
      add(outlist, putit)
      next repeat
    end if
    add(outlist, putit)
  end repeat
  return outlist
end

on playsong inlist, specialljud
  global ljudlista, nystart, tillbaka
  put inlist
  repeat with X = 1 to count(inlist)
    nystart = 0
    tillbaka = 0
    if voidp(specialljud) then
      puppetSound(getAt(ljudlista, X))
    else
      if X = count(inlist) then
        puppetSound(getAt(ljudlista, random(count(ljudlista))))
      end if
    end if
    set the visible of sprite getAt(inlist, X) to 0
    set the visible of sprite (getAt(inlist, X) + 4) to 1
    updateStage()
    repeat while soundBusy(1)
      knapptest()
    end repeat
    if nystart = 1 then
      go("init")
      exit repeat
    else
      if tillbaka = 1 then
        puppetSprite(12, 0)
        puppetTransition(10)
        go("tillbaka")
        exit repeat
      end if
    end if
    set the visible of sprite (getAt(inlist, X) + 4) to 0
    set the visible of sprite getAt(inlist, X) to 1
  end repeat
end

on checksong
  global anvlista, randomlista
  repeat with X = 1 to count(anvlista)
    if getAt(anvlista, X) <> getAt(randomlista, X) then
      return 0
    end if
  end repeat
  return 1
end
