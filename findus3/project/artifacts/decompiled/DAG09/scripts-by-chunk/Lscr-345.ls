global plats, aktiv, klar, ove

on idle
  if the mouseUp then
    if (rollOver(14) and (the moveableSprite of sprite 14 = 1)) or (rollOver(15) and (the moveableSprite of sprite 15 = 1)) or (rollOver(16) and (the moveableSprite of sprite 16 = 1)) or (rollOver(17) and (the moveableSprite of sprite 17 = 1)) or (rollOver(18) and (the moveableSprite of sprite 18 = 1)) or (rollOver(19) and (the moveableSprite of sprite 19 = 1)) or (rollOver(20) and (the moveableSprite of sprite 20 = 1)) then
      cursor([34, 37])
    else
      if rollOver(22) or rollOver(23) then
        cursor([33, 36])
      else
        cursor(0)
      end if
    end if
    if rollOver(22) then
      set the visible of sprite 22 to 1
    else
      set the visible of sprite 22 to 0
    end if
    if rollOver(23) then
      set the visible of sprite 23 to 1
    else
      set the visible of sprite 23 to 0
    end if
    updateStage()
  else
    if (aktiv = 14) and sprite 12 intersects 4 then
      cursor([31, 32])
    else
      if (aktiv = 15) and sprite 12 intersects 5 then
        cursor([31, 32])
      else
        if (aktiv = 16) and sprite 12 intersects 6 then
          cursor([31, 32])
        else
          if (aktiv = 17) and sprite 12 intersects 7 then
            cursor([31, 32])
          else
            if (aktiv = 18) and sprite 12 intersects 8 then
              cursor([31, 32])
            else
              if (aktiv = 19) and sprite 12 intersects 9 then
                cursor([31, 32])
              else
                if (aktiv = 20) and sprite 12 intersects 10 then
                  cursor([31, 32])
                else
                  if (rollOver(14) and (the moveableSprite of sprite 14 = 1)) or (rollOver(15) and (the moveableSprite of sprite 15 = 1)) or (rollOver(16) and (the moveableSprite of sprite 16 = 1)) or (rollOver(17) and (the moveableSprite of sprite 17 = 1)) or (rollOver(18) and (the moveableSprite of sprite 18 = 1)) or (rollOver(19) and (the moveableSprite of sprite 19 = 1)) or (rollOver(20) and (the moveableSprite of sprite 20 = 1)) then
                    cursor([35, 38])
                  else
                    if rollOver(23) or rollOver(24) then
                      cursor([33, 36])
                    else
                      cursor(0)
                    end if
                  end if
                end if
              end if
            end if
          end if
        end if
      end if
    end if
  end if
  set the loc of sprite 12 to the loc of sprite aktiv
  updateStage()
end

on mouseDown
  if ove = 1 then
    exit
  end if
  if (the clickOn > 13) and (the clickOn < 21) then
    aktiv = the clickOn
    puppetSprite(aktiv, 1)
    puppetSprite(12, 1)
    if aktiv = 13 then
      plats = point(330, 245)
    else
      if aktiv = 14 then
        plats = point(519, 411)
      else
        if aktiv = 15 then
          plats = point(569, 364)
        else
          if aktiv = 16 then
            plats = point(447, 362)
          else
            if aktiv = 17 then
              plats = point(546, 384)
            else
              if aktiv = 18 then
                plats = point(559, 378)
              else
                if aktiv = 19 then
                  plats = point(483, 409)
                else
                  if aktiv = 20 then
                    plats = point(493, 361)
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
          set the visible of sprite 22 to 1
          cursor([33, 36])
        else
          set the visible of sprite 22 to 0
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
            set the visible of sprite 23 to 1
            cursor([33, 36])
          else
            set the visible of sprite 23 to 0
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
  updateStage()
  case aktiv of
    14:
      if sprite 12 intersects 4 then
        set the loc of sprite aktiv to point(331, 189)
        set the moveableSprite of sprite aktiv to 0
        klar = klar + 1
        if random(3) = 1 then
          puppetSound("bra" & random(3))
        end if
      else
        set the loc of sprite aktiv to plats
        if random(3) = 1 then
          puppetSound("nej")
        end if
      end if
    15:
      if sprite 12 intersects 5 then
        set the loc of sprite aktiv to point(334, 177)
        set the moveableSprite of sprite aktiv to 0
        klar = klar + 1
        if random(3) = 1 then
          puppetSound("bra" & random(3))
        end if
      else
        set the loc of sprite aktiv to plats
        if random(3) = 1 then
          puppetSound("nej")
        end if
      end if
    16:
      if sprite 12 intersects 6 then
        set the loc of sprite aktiv to point(336, 188)
        set the moveableSprite of sprite aktiv to 0
        klar = klar + 1
        if random(3) = 1 then
          puppetSound("bra" & random(3))
        end if
      else
        set the loc of sprite aktiv to plats
        if random(3) = 1 then
          puppetSound("nej")
        end if
      end if
    17:
      if sprite 12 intersects 7 then
        set the loc of sprite aktiv to point(327, 233)
        set the moveableSprite of sprite aktiv to 0
        klar = klar + 1
        if random(3) = 1 then
          puppetSound("bra" & random(3))
        end if
      else
        set the loc of sprite aktiv to plats
        if random(3) = 1 then
          puppetSound("nej")
        end if
      end if
    18:
      if sprite 12 intersects 8 then
        set the loc of sprite aktiv to point(318, 223)
        set the moveableSprite of sprite aktiv to 0
        klar = klar + 1
        if random(3) = 1 then
          puppetSound("bra" & random(3))
        end if
      else
        set the loc of sprite aktiv to plats
        if random(3) = 1 then
          puppetSound("nej")
        end if
      end if
    19:
      if sprite 12 intersects 9 then
        set the loc of sprite aktiv to point(302, 277)
        set the moveableSprite of sprite aktiv to 0
        klar = klar + 1
        if random(3) = 1 then
          puppetSound("bra" & random(3))
        end if
      else
        set the loc of sprite aktiv to plats
        if random(3) = 1 then
          puppetSound("nej")
        end if
      end if
    20:
      if sprite 12 intersects 10 then
        set the loc of sprite aktiv to point(318, 283)
        set the moveableSprite of sprite aktiv to 0
        klar = klar + 1
        if random(3) = 1 then
          puppetSound("bra" & random(3))
        end if
      else
        set the loc of sprite aktiv to plats
        if random(3) = 1 then
          puppetSound("nej")
        end if
      end if
  end case
  if klar = 7 then
    repeat with Y = 14 to 20
      puppetSprite(Y, 0)
    end repeat
    puppetSound("klart.aif")
    go("klar")
  end if
  updateStage()
end

on exitFrame
  ove = 0
  puppetTempo(15)
  updateStage()
  go(the frame)
end
