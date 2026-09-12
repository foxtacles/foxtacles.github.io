global gPath, gPathLen, gPathPos, gPathDist, gNumObjects, gSortList, gEditSortList, gObjectList, gFindus, gFindusGhost, gGran

on createObjects
  gSortList = list()
  gEditSortList = list()
  gGran = new(script("actor_script"), 10)
  add(gSortList, gGran)
  add(gEditSortList, gGran)
  gObjectList = list()
  repeat with i = 1 to gNumObjects
    obj = new(script("actor_script"), 10 + i)
    add(gObjectList, obj)
    add(gSortList, obj)
  end repeat
  gFindus = getAt(gObjectList, 1)
  gFindusGhost = getAt(gObjectList, 2)
  add(gEditSortList, gFindus)
  add(gEditSortList, gFindusGhost)
end

on positionObjects
  pos = gPathPos
  repeat with i = 1 to gNumObjects
    p = getAt(gPath, pos)
    obj = getAt(gObjectList, i)
    setpos(obj, p)
    pos = pos - gPathDist
    if pos > gPathLen then
      pos = pos - gPathLen
    else
      if pos < 1 then
        pos = gPathLen + pos
      end if
    end if
    pos = max(1, min(gPathLen, pos))
  end repeat
end

on sortObjects baseSprite, sortList
  templist = [999: 10]
  repeat with i = 1 to count(sortList)
    obj = getAt(sortList, i)
    addProp(templist, obj.currpos.locV, i)
  end repeat
  sort(templist)
  repeat with i = 1 to count(templist) - 1
    n = getAt(templist, i)
    obj = getAt(sortList, n)
    setsprite(obj, baseSprite + i - 1)
  end repeat
end
