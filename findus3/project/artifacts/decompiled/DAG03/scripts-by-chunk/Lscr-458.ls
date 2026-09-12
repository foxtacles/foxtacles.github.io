global click, score, lastscore, lastClick, slumplistan, allaklarade, antalkvar

on mouseUp
  if getAt(slumplistan, the clickOn - 9) <> 0 then
    lastClick = click
    lastscore = score
    score = the clickOn - 9
    click = getAt(slumplistan, the clickOn - 9)
    puppetSound(click)
    updateStage()
    if click <> 0 then
      if (lastClick = click) and (score <> lastscore) then
        setAt(slumplistan, score, 0)
        setAt(slumplistan, lastscore, 0)
        put "vilken position i scoren", the clickOn - 9
        put "slumplistan", slumplistan
        Wait(80)
        cursor(0)
        puppetSound("DAG03_F_RIGHT.AIF")
        updateStage()
        Wait(20)
        antalkvar = antalkvar - 1
        set the castNum of sprite 45 to 70 + antalkvar
        updateStage()
      end if
      repeat with i in slumplistan
        if i <> 0 then
          allaklarade = 0
          exit repeat
        end if
        allaklarade = 1
      end repeat
      if allaklarade <> 0 then
        set the visible of sprite 44 to 0
        set the visible of sprite 46 to 0
        Wait(60)
        puppetSound(3, random(3) + 52)
        Wait(120)
        go(#next)
      end if
    end if
  end if
end
