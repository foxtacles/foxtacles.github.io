on IsObjOverOldSpik thisKanal, thisAntalSpikar
  global cSwapToleransX, cDinkLjudMemberNum
  mainX = the locH of sprite thisKanal
  repeat with i = thisKanal - 1 down to thisKanal - thisAntalSpikar
    thisX = the locH of sprite i
    if ((thisX - cSwapToleransX) < mainX) and (mainX < (thisX + cSwapToleransX)) then
      return 1
    end if
  end repeat
  return 0
end
