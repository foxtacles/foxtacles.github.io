global plats, aktiv, ove, fyfyra, fyfem, fysex, fysju, fyatta, fynio, fetio, feett, fetva, fetre, fefyra, fefem, fesex, fesju, featta, fenio, setio, seett, setva, setre, sefyra, sefem, sesex

on idle
  if the mouseUp then
    if rollOver(44) or rollOver(45) or rollOver(46) or rollOver(47) or rollOver(48) or rollOver(49) or rollOver(50) or rollOver(51) or rollOver(52) or rollOver(53) or rollOver(54) or rollOver(55) or rollOver(56) or rollOver(57) or rollOver(58) or rollOver(59) or rollOver(60) or rollOver(61) or rollOver(62) or rollOver(63) or rollOver(64) then
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
    if rollOver(44) or rollOver(45) or rollOver(46) or rollOver(47) or rollOver(48) or rollOver(49) or rollOver(50) or rollOver(51) or rollOver(52) or rollOver(53) or rollOver(54) or rollOver(55) or rollOver(56) or rollOver(57) or rollOver(58) or rollOver(59) or rollOver(60) or rollOver(61) or rollOver(62) or rollOver(63) or rollOver(64) then
      cursor([35, 38])
    else
      if rollOver(40) or rollOver(41) then
        cursor([33, 36])
      else
        cursor(0)
      end if
    end if
  end if
  set the loc of sprite 12 to the loc of sprite aktiv
  set the loc of sprite 70 to the loc of sprite aktiv
  updateStage()
end

on mouseDown
  if ove = 1 then
    exit
  end if
  if (the clickOn > 43) and (the clickOn < 65) then
    aktiv = the clickOn
    aktivCast = the memberNum of sprite aktiv
    puppetSprite(aktiv, 1)
    sprite(aktiv).visible = 1
    set the memberNum of sprite 70 to aktivCast
    set the loc of sprite 70 to the loc of sprite aktiv
    sprite(70).visible = 1
    updateStage()
    puppetSprite(12, 1)
    if aktiv = 44 then
      plats = point(574, 258)
    else
      if aktiv = 45 then
        plats = point(589, 258)
      else
        if aktiv = 46 then
          plats = point(603, 258)
        else
          if aktiv = 47 then
            plats = point(575, 269)
          else
            if aktiv = 48 then
              plats = point(589, 269)
            else
              if aktiv = 49 then
                plats = point(603, 270)
              else
                if aktiv = 50 then
                  plats = point(575, 281)
                else
                  if aktiv = 51 then
                    plats = point(590, 281)
                  else
                    if aktiv = 52 then
                      plats = point(603, 282)
                    else
                      if aktiv = 53 then
                        plats = point(576, 292)
                      else
                        if aktiv = 54 then
                          plats = point(589, 293)
                        else
                          if aktiv = 55 then
                            plats = point(603, 294)
                          else
                            if aktiv = 56 then
                              plats = point(536, 388)
                            else
                              if aktiv = 57 then
                                plats = point(533, 385)
                              else
                                if aktiv = 58 then
                                  plats = point(530, 382)
                                else
                                  if aktiv = 59 then
                                    plats = point(590, 351)
                                  else
                                    if aktiv = 60 then
                                      plats = point(587, 348)
                                    else
                                      if aktiv = 61 then
                                        plats = point(584, 345)
                                      else
                                        if aktiv = 62 then
                                          plats = point(597, 387)
                                        else
                                          if aktiv = 63 then
                                            plats = point(594, 384)
                                          else
                                            if aktiv = 64 then
                                              plats = point(591, 381)
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
        aktiv = 0
        if rollOver(41) then
          omstart()
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
  sprite(70).visible = 0
  updateStage()
  updateStage()
  if aktiv <> 0 then
    if (aktiv > 43) and (aktiv < 56) and sprite 12 intersects 2 then
      if random(3) = 1 then
        puppetSound("bra" & random(2))
      end if
      if aktiv = 44 then
        fyfyra = 1
      end if
      if aktiv = 45 then
        fyfem = 1
      end if
      if aktiv = 46 then
        fysex = 1
      end if
      if aktiv = 47 then
        fysju = 1
      end if
      if aktiv = 48 then
        fyatta = 1
      end if
      if aktiv = 49 then
        fynio = 1
      end if
      if aktiv = 50 then
        fetio = 1
      end if
      if aktiv = 51 then
        feett = 1
      end if
      if aktiv = 52 then
        fetva = 1
      end if
      if aktiv = 53 then
        fetre = 1
      end if
      if aktiv = 54 then
        fefyra = 1
      end if
      if aktiv = 55 then
        fefem = 1
      end if
    else
      if (aktiv > 55) and (aktiv < 65) and sprite 12 intersects 3 then
        if random(4) = 1 then
          puppetSound("bra" & random(2))
        end if
        if aktiv = 56 then
          fesex = 1
        end if
        if aktiv = 57 then
          fesju = 1
        end if
        if aktiv = 58 then
          featta = 1
        end if
        if aktiv = 59 then
          fenio = 1
        end if
        if aktiv = 60 then
          setio = 1
        end if
        if aktiv = 61 then
          seett = 1
        end if
        if aktiv = 62 then
          setva = 1
        end if
        if aktiv = 63 then
          setre = 1
        end if
        if aktiv = 64 then
          sefyra = 1
        end if
      else
        if random(2) = 1 then
          puppetSound("fel")
        end if
        set the loc of sprite aktiv to plats
        if aktiv = 44 then
          fyfyra = 0
        end if
        if aktiv = 45 then
          fyfem = 0
        end if
        if aktiv = 46 then
          fysex = 0
        end if
        if aktiv = 47 then
          fysju = 0
        end if
        if aktiv = 48 then
          fyatta = 0
        end if
        if aktiv = 49 then
          fynio = 0
        end if
        if aktiv = 50 then
          fetio = 0
        end if
        if aktiv = 51 then
          feett = 0
        end if
        if aktiv = 52 then
          fetva = 0
        end if
        if aktiv = 53 then
          fetre = 0
        end if
        if aktiv = 54 then
          fefyra = 0
        end if
        if aktiv = 55 then
          fefem = 0
        end if
        if aktiv = 56 then
          fesex = 0
        end if
        if aktiv = 57 then
          fesju = 0
        end if
        if aktiv = 58 then
          featta = 0
        end if
        if aktiv = 59 then
          fenio = 0
        end if
        if aktiv = 60 then
          setio = 0
        end if
        if aktiv = 61 then
          seett = 0
        end if
        if aktiv = 62 then
          setva = 0
        end if
        if aktiv = 63 then
          setre = 0
        end if
        if aktiv = 64 then
          sefyra = 0
        end if
      end if
    end if
    if (fyfyra = 1) and (fyfem = 1) and (fysex = 1) and (fysju = 1) and (fyatta = 1) and (fynio = 1) and (fetio = 1) and (feett = 1) and (fetva = 1) and (fetre = 1) and (fefyra = 1) and (fefem = 1) and (fesex = 1) and (fesju = 1) and (featta = 1) and (fenio = 1) and (setio = 1) and (seett = 1) and (setva = 1) and (setre = 1) and (sefyra = 1) then
      puppetSound("klart2.aif")
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
