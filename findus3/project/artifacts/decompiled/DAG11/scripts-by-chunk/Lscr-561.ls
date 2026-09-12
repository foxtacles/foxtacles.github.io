global klar, ove, aktiv, spriteEtt, spriteTva, spriteTre, rimEtt, rimTva, rimTre, rimFyra, posEtt, posTva, posTre, rPosEtt, rPosTva, rPosTre, rPosFyra

on idle
  if the mouseUp then
    if (rollOver(spriteEtt) and (the moveableSprite of sprite spriteEtt = 1)) or (rollOver(spriteTva) and (the moveableSprite of sprite spriteTva = 1)) or (rollOver(spriteTre) and (the moveableSprite of sprite spriteTre = 1)) then
      cursor([34, 37])
    else
      if rollOver(22) or rollOver(23) or (rollOver(rimEtt) and (sprite(rimEtt).visible = 1)) or (rollOver(rimTva) and (sprite(rimTva).visible = 1)) or (rollOver(rimTre) and (sprite(rimTre).visible = 1)) or rollOver(rimFyra) then
        cursor([33, 36])
      else
        cursor(0)
      end if
    end if
    if rollOver(22) then
      sprite(22).visible = 1
    else
      sprite(22).visible = 0
    end if
    if rollOver(23) then
      sprite(23).visible = 1
    else
      sprite(23).visible = 0
    end if
    updateStage()
  else
    if (rollOver(spriteEtt) and (the moveableSprite of sprite spriteEtt = 1)) or (rollOver(spriteTva) and (the moveableSprite of sprite spriteTva = 1)) or (rollOver(spriteTre) and (the moveableSprite of sprite spriteTre = 1)) then
      cursor([35, 38])
    else
      if rollOver(23) or rollOver(24) then
        cursor([33, 36])
      else
        cursor(0)
      end if
    end if
  end if
  set the loc of sprite 1 to the loc of sprite aktiv
  updateStage()
end

on mouseDown
  if ove = 1 then
    exit
  end if
  if (the clickOn > 12) and (the clickOn < 22) then
    aktiv = the clickOn
  end if
  if rollOver(22) then
    repeat while the mouseDown
      if rollOver(22) then
        sprite(22).visible = 1
        cursor([33, 36])
      else
        sprite(22).visible = 0
        cursor(0)
      end if
      updateStage()
    end repeat
    if rollOver(22) then
      cursor(4)
      puppetTransition(10)
      go("vidare")
    end if
  else
    if rollOver(23) then
      repeat while the mouseDown
        if rollOver(23) then
          sprite(23).visible = 1
          cursor([33, 36])
        else
          sprite(23).visible = 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(23) then
        repeat with k = 3 to 21
          puppetSprite(k, 0)
          sprite(k).loc = point(-1000, -1000)
        end repeat
        sprite(12).visible = 1
        updateStage()
        omstart()
      end if
    end if
  end if
end

on mouseUp
  rplatslist = [point(105, 145), point(109, 300), point(525, 180), point(522, 333)]
  case aktiv of
    spriteEtt:
      if sprite 1 intersects rimEtt then
        oldEtt = the memberNum of sprite spriteEtt
        platsen = the loc of sprite rimEtt
        case platsen of
          getAt(rplatslist, 1):
            set the memberNum of sprite spriteEtt to member("paket1").memberNum
          getAt(rplatslist, 2):
            set the memberNum of sprite spriteEtt to member("paket2").memberNum
          getAt(rplatslist, 3):
            set the memberNum of sprite spriteEtt to member("paket3").memberNum
          getAt(rplatslist, 4):
            set the memberNum of sprite spriteEtt to member("paket4").memberNum
        end case
        set the loc of sprite spriteEtt to the loc of sprite rimEtt
        sprite(rimEtt).visible = 0
        set the moveableSprite of sprite spriteEtt to 0
        klar = klar + 1
        puppetSound(0)
        if random(4) = 1 then
          puppetSound("bra" & random(5))
        else
          if klar = 3 then
            puppetSound("bra" & random(5))
          end if
        end if
      else
        if sprite 1 intersects rimTva or sprite 1 intersects rimTre or sprite 1 intersects rimFyra then
          cursor(0)
          puppetSound(1, "fel" & random(3))
          repeat while soundBusy(1)
            if the mouseDown then
              exit repeat
            end if
          end repeat
          set the loc of sprite spriteEtt to posEtt
        else
          set the loc of sprite spriteEtt to posEtt
        end if
      end if
    spriteTva:
      if sprite 1 intersects rimTva then
        oldTva = the memberNum of sprite spriteEtt
        platsen = the loc of sprite rimTva
        case platsen of
          getAt(rplatslist, 1):
            set the memberNum of sprite spriteTva to member("paket1").memberNum
          getAt(rplatslist, 2):
            set the memberNum of sprite spriteTva to member("paket2").memberNum
          getAt(rplatslist, 3):
            set the memberNum of sprite spriteTva to member("paket3").memberNum
          getAt(rplatslist, 4):
            set the memberNum of sprite spriteTva to member("paket4").memberNum
        end case
        set the loc of sprite spriteTva to the loc of sprite rimTva
        sprite(rimTva).visible = 0
        set the moveableSprite of sprite spriteTva to 0
        klar = klar + 1
        puppetSound(0)
        if random(4) = 1 then
          puppetSound("bra" & random(5))
        else
          if klar = 3 then
            puppetSound("bra" & random(5))
          end if
        end if
      else
        if sprite 1 intersects rimEtt or sprite 1 intersects rimTre or sprite 1 intersects rimFyra then
          cursor(0)
          puppetSound(1, "fel" & random(3))
          repeat while soundBusy(1)
            if the mouseDown then
              exit repeat
            end if
          end repeat
          set the loc of sprite spriteTva to posTva
        else
          set the loc of sprite spriteTva to posTva
        end if
      end if
    spriteTre:
      if sprite 1 intersects rimTre then
        oldTre = the memberNum of sprite spriteEtt
        platsen = the loc of sprite rimTre
        case platsen of
          getAt(rplatslist, 1):
            set the memberNum of sprite spriteTre to member("paket1").memberNum
          getAt(rplatslist, 2):
            set the memberNum of sprite spriteTre to member("paket2").memberNum
          getAt(rplatslist, 3):
            set the memberNum of sprite spriteTre to member("paket3").memberNum
          getAt(rplatslist, 4):
            set the memberNum of sprite spriteTre to member("paket4").memberNum
        end case
        set the loc of sprite spriteTre to the loc of sprite rimTre
        sprite(rimTre).visible = 0
        set the moveableSprite of sprite spriteTre to 0
        klar = klar + 1
        puppetSound(0)
        if random(4) = 1 then
          puppetSound("bra" & random(5))
        else
          if klar = 3 then
            puppetSound("bra" & random(5))
          end if
        end if
      else
        if sprite 1 intersects rimEtt or sprite 1 intersects rimTva or sprite 1 intersects rimFyra then
          cursor(0)
          puppetSound(1, "fel" & random(3))
          repeat while soundBusy(1)
            if the mouseDown then
              exit repeat
            end if
          end repeat
          set the loc of sprite spriteTre to posTre
        else
          set the loc of sprite spriteTre to posTre
        end if
      end if
  end case
  aktiv = 2
  updateStage()
  if klar = 3 then
    cursor(0)
    set the memberNum of sprite spriteEtt to oldEtt
    set the memberNum of sprite spriteTva to oldTva
    set the memberNum of sprite spriteTre to oldTre
    repeat with k = 3 to 21
      puppetSprite(k, 0)
      sprite(k).loc = point(-1000, -1000)
    end repeat
    repeat while soundBusy(1)
      if the mouseDown then
        exit repeat
      end if
    end repeat
    puppetSound("klart.aif")
    go("klar")
    exit
  end if
end

on exitFrame
  ove = 0
  puppetTempo(15)
  updateStage()
  go(the frame)
end
