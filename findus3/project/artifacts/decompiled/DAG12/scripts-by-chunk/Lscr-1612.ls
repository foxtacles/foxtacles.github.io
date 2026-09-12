on soundEngine sounds, objects
  global G_soundList, G_soundObjects, G_soundActive1, G_soundActive2, gameObjectList
  repeat with i = 1 to count(sounds)
    AvChan = 0
    repeat with j = 1 to 4
      if soundBusy(j) = 0 then
        AvChan = j
        exit repeat
      end if
    end repeat
    if (AvChan > 0) and (getAt(sounds, i) > EMPTY) then
      puppetSound(AvChan, getAt(sounds, i))
    end if
  end repeat
  return 
  if (G_soundActive1 <> 0) and not soundBusy(1) then
    pos = getPos(G_soundObjects, G_soundActive1)
    deleteAt(G_soundList, pos)
    deleteAt(G_soundObjects, pos)
    G_soundActive1 = 0
  end if
  loopVar2 = count(sounds)
  repeat with i = 1 to loopVar2
    if sounds[i] <> EMPTY then
      playSounds(sounds[i], objects[i])
    end if
  end repeat
  loopVar1 = count(objects)
  repeat with j = 1 to loopVar1
    pointer = objects[j]
    tObj = gameObjectList[pointer]
    if (tObj.aktiv = 0) and (G_soundActive1 = pointer) and soundBusy(1) then
      pos = getPos(G_soundObjects, G_soundActive1)
      deleteAt(G_soundList, pos)
      deleteAt(G_soundObjects, pos)
      G_soundActive1 = 0
      puppetSound(1, 0)
    end if
  end repeat
end

on playSounds theSound, ObjectNr
  global G_soundList, G_soundObjects, G_soundActive1, G_soundActive2
  if G_soundActive1 = 0 then
    puppetSound(1, theSound)
    G_soundActive1 = ObjectNr
    add(G_soundObjects, G_soundActive1)
    add(G_soundList, theSound)
  end if
end
