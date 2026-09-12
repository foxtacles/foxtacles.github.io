global spriteBeingDragged

on checkDragging mousePos
  global UNIObjectList, gameObjectList, objectBeingDragged, offCenter, dragSpritePosList, spriteInBowl, holdStage, ingredientList
  if the mouseDown and (spriteBeingDragged = 0) then
    repeat with i = 6 to 10
      if sprite(i).rollOver = 1 then
        spriteBeingDragged = i
        offCenter = the loc of sprite i - mousePos
        exit repeat
      end if
    end repeat
  else
    if the mouseDown and (spriteBeingDragged <> 0) then
      checkInBowl()
      set the loc of sprite spriteBeingDragged to mousePos + offCenter
    else
      if not (the mouseDown) and (spriteBeingDragged <> 0) then
        if spriteInBowl <> 0 then
          holdStage = 0
          add(ingredientList, spriteBeingDragged)
          whichIngredient(spriteBeingDragged)
          repeat with j = 6 to 10
            set the loc of sprite j to point(-1000, -1000)
          end repeat
        else
          set the loc of sprite spriteBeingDragged to dragSpritePosList[spriteBeingDragged - 5]
          sprite(spriteBeingDragged).locZ = spriteBeingDragged
          if not soundBusy(2) then
            puppetSound(2, "Baka14")
          end if
        end if
        spriteBeingDragged = 0
        spriteInBowl = 0
      end if
    end if
  end if
end

on checkInBowl
  global spriteBeingDragged, spriteInBowl
  b = spriteBeingDragged
  if sprite b intersects 13 and ((sprite(b).left < (sprite(13).left + 10)) or (sprite(b).right > (sprite(13).right - 10)) or (sprite(b).bottom > (sprite(13).bottom - 15))) then
    sprite(b).locZ = b + 50
    spriteInBowl = 0
  else
    if sprite b intersects 13 then
      sprite(b).locZ = b
      spriteInBowl = spriteBeingDragged
    else
      spriteInBowl = 0
    end if
  end if
  return 
end
