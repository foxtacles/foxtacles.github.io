on checkDragging_old mousePos
  global spriteBeingDragged, UNIObjectList, gameObjectList, objectBeingDragged
  if the mouseDown and (spriteBeingDragged = 0) then
    values = count(UNIObjectList)
    repeat with i = 1 to values
      theNumber = UNIObjectList[i].UNIobjectNr
      theSprite = gameObjectList[theNumber].SpriteNr
      if sprite(theSprite).rollOver then
        spriteBeingDragged = theSprite
        objectBeingDragged = theNumber
      end if
    end repeat
  else
    if the mouseDown and (spriteBeingDragged <> 0) then
      repeat with i = 1 to count(UNIObjectList)
        if UNIObjectList[i].UNIspriteNr = spriteBeingDragged then
          set the locH of sprite spriteBeingDragged to mousePos.locH
          set the locV of sprite spriteBeingDragged to mousePos.locV
        end if
      end repeat
    else
      if not (the mouseDown) and (spriteBeingDragged <> 0) then
        spriteBeingDragged = 0
        objectBeingDragged = 0
      end if
    end if
  end if
end
