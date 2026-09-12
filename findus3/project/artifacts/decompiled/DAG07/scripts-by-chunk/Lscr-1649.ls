global plats, aktiv, klar, ove, aktivCast, LinusR

on idle
  if the mouseUp then
    if (rollOver(13) and (the moveableSprite of sprite 13 = 1)) or (rollOver(14) and (the moveableSprite of sprite 14 = 1)) or (rollOver(15) and (the moveableSprite of sprite 15 = 1)) or (rollOver(16) and (the moveableSprite of sprite 16 = 1)) or (rollOver(17) and (the moveableSprite of sprite 17 = 1)) or (rollOver(18) and (the moveableSprite of sprite 18 = 1)) or (rollOver(19) and (the moveableSprite of sprite 19 = 1)) or (rollOver(20) and (the moveableSprite of sprite 20 = 1)) or (rollOver(21) and (the moveableSprite of sprite 21 = 1)) then
      cursor([34, 37])
    else
      if rollOver(22) or rollOver(23) then
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
    if (rollOver(13) and (the moveableSprite of sprite 13 = 1)) or (rollOver(14) and (the moveableSprite of sprite 14 = 1)) or (rollOver(15) and (the moveableSprite of sprite 15 = 1)) or (rollOver(16) and (the moveableSprite of sprite 16 = 1)) or (rollOver(17) and (the moveableSprite of sprite 17 = 1)) or (rollOver(18) and (the moveableSprite of sprite 18 = 1)) or (rollOver(19) and (the moveableSprite of sprite 19 = 1)) or (rollOver(20) and (the moveableSprite of sprite 20 = 1)) or (rollOver(21) and (the moveableSprite of sprite 21 = 1)) then
      cursor([35, 38])
    else
      if rollOver(22) or rollOver(23) then
        cursor([33, 36])
      else
        cursor(0)
      end if
    end if
  end if
  set the loc of sprite 12 to the loc of sprite aktiv
  set the loc of sprite 24 to the loc of sprite aktiv
  updateStage()
end

on mouseDown
  if ove = 1 then
    exit
  end if
  if (the clickOn > 12) and (the clickOn < 22) then
    aktiv = the clickOn
    aktivCast = the memberNum of sprite aktiv
    puppetSprite(aktiv, 1)
    set the memberNum of sprite 24 to aktivCast
    set the loc of sprite 24 to the loc of sprite aktiv
    sprite(24).visible = 1
    updateStage()
    puppetSprite(12, 1)
    if aktiv = 13 then
      plats = point(122, 312)
    else
      if aktiv = 14 then
        plats = point(526, 199)
      else
        if aktiv = 15 then
          plats = point(69, 249)
        else
          if aktiv = 16 then
            plats = point(556, 328)
          else
            if aktiv = 17 then
              plats = point(503, 266)
            else
              if aktiv = 18 then
                plats = point(119, 159)
              else
                if aktiv = 19 then
                  plats = point(85, 82)
                else
                  if aktiv = 20 then
                    plats = point(577, 166)
                  else
                    if aktiv = 21 then
                      plats = point(510, 79)
                    end if
                  end if
                end if
              end if
            end if
          end if
        end if
      end if
    end if
  else
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
          omstart()
        end if
      else
        aktiv = 0
      end if
    end if
  end if
end

on mouseUp
  global LinCast
  if aktiv > 0 then
    sprite(aktiv).visible = 1
  end if
  sprite(24).visible = 0
  updateStage()
  if aktiv <> 0 then
    NyC = aktivCast - LinCast + 3
    case NyC of
      3:
        if sprite 12 intersects 2 then
          set the loc of sprite aktiv to point(233, 147)
          set the moveableSprite of sprite aktiv to 0
          klar = klar + 1
          puppetSound(1, "bra" & random(6))
        else
          set the loc of sprite aktiv to plats
        end if
      4:
        if sprite 12 intersects 3 then
          set the loc of sprite aktiv to point(302, 146)
          set the moveableSprite of sprite aktiv to 0
          klar = klar + 1
          puppetSound(1, "bra" & random(6))
        else
          set the loc of sprite aktiv to plats
        end if
      5:
        if sprite 12 intersects 4 then
          set the loc of sprite aktiv to point(374, 154)
          set the moveableSprite of sprite aktiv to 0
          klar = klar + 1
          puppetSound(1, "bra" & random(6))
        else
          set the loc of sprite aktiv to plats
        end if
      6:
        if sprite 12 intersects 5 then
          set the loc of sprite aktiv to point(234, 224)
          set the moveableSprite of sprite aktiv to 0
          klar = klar + 1
          puppetSound(1, "bra" & random(2))
        else
          set the loc of sprite aktiv to plats
        end if
      7:
        if sprite 12 intersects 6 then
          set the loc of sprite aktiv to point(302, 223)
          set the moveableSprite of sprite aktiv to 0
          klar = klar + 1
          puppetSound(1, "bra" & random(6))
        else
          set the loc of sprite aktiv to plats
        end if
      8:
        if sprite 12 intersects 7 then
          set the loc of sprite aktiv to point(373, 227)
          set the moveableSprite of sprite aktiv to 0
          klar = klar + 1
          puppetSound(1, "bra" & random(6))
        else
          set the loc of sprite aktiv to plats
        end if
      9:
        if sprite 12 intersects 8 then
          set the loc of sprite aktiv to point(234, 304)
          set the moveableSprite of sprite aktiv to 0
          klar = klar + 1
          puppetSound(1, "bra" & random(6))
        else
          set the loc of sprite aktiv to plats
        end if
      10:
        if sprite 12 intersects 9 then
          set the loc of sprite aktiv to point(302, 305)
          set the moveableSprite of sprite aktiv to 0
          klar = klar + 1
          puppetSound(1, "bra" & random(2))
        else
          set the loc of sprite aktiv to plats
        end if
      11:
        if sprite 12 intersects 10 then
          set the loc of sprite aktiv to point(375, 296)
          set the moveableSprite of sprite aktiv to 0
          klar = klar + 1
          puppetSound(1, "bra" & random(6))
        else
          set the loc of sprite aktiv to plats
        end if
    end case
    if klar = 9 then
      put "ll", 209 + LinusR + 1
      updateStage()
      puppetSound(1, member(209 + LinusR + 1, "internal"))
      updateStage()
      go("klar")
    end if
  end if
  updateStage()
end

on exitFrame
  ove = 0
  puppetTempo(15)
  updateStage()
  go(the frame)
end
