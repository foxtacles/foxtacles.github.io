global gFindus

on doLayers
  yfindus = gFindus.yPos
  i = 20
  c = the memberNum of sprite i
  repeat while c > 0
    if the locV of sprite i > yfindus then
      set the visible of sprite i to 1
    else
      set the visible of sprite i to 0
    end if
    i = i + 1
    c = the memberNum of sprite i
  end repeat
end
