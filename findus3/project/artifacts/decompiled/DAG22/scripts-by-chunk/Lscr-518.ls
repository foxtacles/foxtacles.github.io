global gAntalPynt, gPyntSprite, gFarg, gAllaFargadeCount

on mouseDown
  n = the clickOn
  if (n >= gPyntSprite) and (n < (gPyntSprite + gAntalPynt)) then
    idx = the memberNum of sprite n mod 20
    set the memberNum of sprite n to the number of member "pynt1" + (20 * gFarg) + idx - 1
    allaFargade = 1
    repeat with i = gPyntSprite to gPyntSprite + gAntalPynt - 1
      if (the memberNum of sprite i < 40) and (i <> n) then
        allaFargade = 0
      end if
    end repeat
    if allaFargade then
      if gAllaFargadeCount <= 0 then
        updateStage()
        repeat while soundBusy(1)
          updateStage()
        end repeat
        puppetSound("Dag22fk" & random(3))
        gAllaFargadeCount = 5
      end if
      gAllaFargadeCount = gAllaFargadeCount - 1
    end if
  end if
end
