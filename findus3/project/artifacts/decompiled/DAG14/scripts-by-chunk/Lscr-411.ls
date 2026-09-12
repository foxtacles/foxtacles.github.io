global plats, aktiv, klar, ove

on idle
  if the mouseUp then
    if (rollOver(21) and (the moveableSprite of sprite 21 = 1)) or (rollOver(22) and (the moveableSprite of sprite 22 = 1)) or (rollOver(23) and (the moveableSprite of sprite 23 = 1)) or (rollOver(24) and (the moveableSprite of sprite 24 = 1)) or (rollOver(25) and (the moveableSprite of sprite 25 = 1)) or (rollOver(26) and (the moveableSprite of sprite 26 = 1)) or (rollOver(27) and (the moveableSprite of sprite 27 = 1)) or (rollOver(28) and (the moveableSprite of sprite 28 = 1)) or (rollOver(29) and (the moveableSprite of sprite 29 = 1)) or (rollOver(30) and (the moveableSprite of sprite 30 = 1)) or (rollOver(31) and (the moveableSprite of sprite 31 = 1)) or (rollOver(32) and (the moveableSprite of sprite 32 = 1)) or (rollOver(33) and (the moveableSprite of sprite 33 = 1)) then
      cursor([34, 37])
    else
      if rollOver(40) or rollOver(41) then
        cursor([33, 36])
      else
        cursor(0)
      end if
    end if
    if rollOver(40) then
      sprite(40).visible = 1
    else
      sprite(40).visible = 0
    end if
    if rollOver(41) then
      sprite(41).visible = 1
    else
      sprite(41).visible = 0
    end if
    updateStage()
  else
    if (aktiv = 21) and sprite 12 intersects 1 then
      cursor([31, 32])
    else
      if (aktiv = 22) and sprite 12 intersects 1 then
        cursor([31, 32])
      else
        if (aktiv = 23) and sprite 12 intersects 1 then
          cursor([31, 32])
        else
          if (aktiv = 24) and sprite 12 intersects 1 then
            cursor([31, 32])
          else
            if (aktiv = 25) and sprite 12 intersects 1 then
              cursor([31, 32])
            else
              if (aktiv = 26) and sprite 12 intersects 1 then
                cursor([31, 32])
              else
                if (aktiv = 27) and sprite 12 intersects 1 then
                  cursor([31, 32])
                else
                  if (aktiv = 28) and sprite 12 intersects 1 then
                    cursor([31, 32])
                  else
                    if (aktiv = 29) and sprite 12 intersects 1 then
                      cursor([31, 32])
                    else
                      if (aktiv = 30) and sprite 12 intersects 1 then
                        cursor([31, 32])
                      else
                        if (aktiv = 31) and sprite 12 intersects 1 then
                          cursor([31, 32])
                        else
                          if (aktiv = 32) and sprite 12 intersects 1 then
                            cursor([31, 32])
                          else
                            if (aktiv = 33) and sprite 12 intersects 1 then
                              cursor([31, 32])
                            else
                              if (rollOver(21) and (the moveableSprite of sprite 21 = 1)) or (rollOver(22) and (the moveableSprite of sprite 22 = 1)) or (rollOver(23) and (the moveableSprite of sprite 23 = 1)) or (rollOver(24) and (the moveableSprite of sprite 24 = 1)) or (rollOver(25) and (the moveableSprite of sprite 25 = 1)) or (rollOver(26) and (the moveableSprite of sprite 26 = 1)) or (rollOver(27) and (the moveableSprite of sprite 27 = 1)) or (rollOver(28) and (the moveableSprite of sprite 28 = 1)) or (rollOver(29) and (the moveableSprite of sprite 29 = 1)) or (rollOver(30) and (the moveableSprite of sprite 30 = 1)) or (rollOver(31) and (the moveableSprite of sprite 31 = 1)) or (rollOver(32) and (the moveableSprite of sprite 32 = 1)) or (rollOver(33) and (the moveableSprite of sprite 33 = 1)) then
                                cursor([35, 38])
                              else
                                if rollOver(40) or rollOver(41) then
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
            end if
          end if
        end if
      end if
    end if
  end if
  set the loc of sprite 12 to the loc of sprite aktiv
  set the loc of sprite 35 to the loc of sprite aktiv
  updateStage()
end

on mouseDown
  if ove = 1 then
    exit
  end if
  if (the clickOn > 20) and (the clickOn < 34) then
    aktiv = the clickOn
    aktivCast = the memberNum of sprite aktiv
    puppetSprite(aktiv, 1)
    sprite(aktiv).visible = 1
    set the memberNum of sprite 35 to aktivCast
    set the loc of sprite 35 to the loc of sprite aktiv
    sprite(35).visible = 1
    updateStage()
    puppetSprite(12, 1)
    if aktiv = 21 then
      plats = point(181, 159)
    else
      if aktiv = 22 then
        plats = point(320, 240)
      else
        if aktiv = 23 then
          plats = point(599, 247)
        else
          if aktiv = 24 then
            plats = point(533, 93)
          else
            if aktiv = 25 then
              plats = point(598, 230)
            else
              if aktiv = 26 then
                plats = point(79, 321)
              else
                if aktiv = 27 then
                  plats = point(-4, 361)
                else
                  if aktiv = 28 then
                    plats = point(30, 60)
                  else
                    if aktiv = 29 then
                      plats = point(219, 2)
                    else
                      if aktiv = 30 then
                        plats = point(123, -6)
                      else
                        if aktiv = 31 then
                          plats = point(203, 187)
                        else
                          if aktiv = 32 then
                            plats = point(1, 55)
                          else
                            if aktiv = 33 then
                              plats = point(536, 80)
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
        end if
      end if
    end if
  else
    if rollOver(40) then
      repeat while the mouseDown
        if rollOver(40) then
          sprite(40).visible = 1
          cursor([33, 36])
        else
          sprite(40).visible = 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(40) then
        aktiv = 0
        repeat with k = 21 to 64
          puppetSprite(k, 1)
        end repeat
        cursor(4)
        puppetTransition(10)
        go("vidare")
      end if
    else
      if rollOver(41) then
        repeat while the mouseDown
          if rollOver(41) then
            sprite(41).visible = 1
            cursor([33, 36])
          else
            sprite(41).visible = 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(41) then
          aktiv = 0
          omstart()
          exit
        end if
      else
        aktiv = 0
      end if
    end if
  end if
end

on mouseUp
  if aktiv > 0 then
    sprite(aktiv).visible = 1
  end if
  sprite(35).visible = 0
  updateStage()
  if aktiv <> 0 then
    if sprite 12 intersects 1 then
      set the loc of sprite aktiv to point(320, 240)
      set the moveableSprite of sprite aktiv to 0
      klar = klar + 1
      if random(3) = 1 then
        puppetSound("bra" & random(2))
      end if
    else
      if random(3) = 1 then
        puppetSound("fel")
      end if
      set the loc of sprite aktiv to plats
    end if
  end if
  if klar = 11 then
    cursor(0)
    puppetSound("klart.aif")
    go("bonus")
  end if
  updateStage()
end

on exitFrame
  ove = 0
  puppetTempo(15)
  updateStage()
  go(the frame)
end
