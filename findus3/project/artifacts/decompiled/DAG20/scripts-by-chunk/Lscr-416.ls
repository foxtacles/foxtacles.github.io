global plats, aktiv, tre, fyra, fem, sex, sju, atta, nio, tio, tretton, fjorton, femton, sexton, sjutton, ove

on idle
  if the mouseUp then
    if rollOver(3) or rollOver(4) or rollOver(5) or rollOver(6) or rollOver(7) or rollOver(8) or rollOver(9) or rollOver(10) or rollOver(13) or rollOver(14) or rollOver(15) or rollOver(16) or rollOver(17) then
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
    if rollOver(3) or rollOver(4) or rollOver(5) or rollOver(6) or rollOver(7) or rollOver(8) or rollOver(9) or rollOver(10) or rollOver(13) or rollOver(14) or rollOver(15) or rollOver(16) or rollOver(17) then
      cursor([35, 38])
    else
      if rollOver(13) or rollOver(14) then
        cursor([33, 36])
      else
        cursor(0)
      end if
    end if
  end if
  updateStage()
end

on mouseDown
  if ove = 1 then
    exit
  end if
  if ((the clickOn > 2) and (the clickOn < 11)) or ((the clickOn > 12) and (the clickOn < 18)) then
    aktiv = the clickOn
    puppetSprite(aktiv, 1)
    puppetSprite(12, 1)
    if aktiv = 3 then
      plats = point(457, 59)
    else
      if aktiv = 4 then
        plats = point(601, 25)
      else
        if aktiv = 5 then
          plats = point(585, 180)
        else
          if aktiv = 6 then
            plats = point(534, 105)
          else
            if aktiv = 7 then
              plats = point(588, 208)
            else
              if aktiv = 8 then
                plats = point(457, 86)
              else
                if aktiv = 9 then
                  plats = point(526, 192)
                else
                  if aktiv = 10 then
                    plats = point(506, 215)
                  else
                    if aktiv = 13 then
                      plats = point(463, 175)
                    else
                      if aktiv = 14 then
                        plats = point(534, 350)
                      else
                        if aktiv = 15 then
                          plats = point(586, 289)
                        else
                          if aktiv = 16 then
                            plats = point(425, 90)
                          else
                            if aktiv = 17 then
                              plats = point(500, 92)
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
  set the loc of sprite 12 to the loc of sprite aktiv
  updateStage()
  if aktiv <> 0 then
    if not (sprite 12 intersects 1) then
      if random(3) = 1 then
        puppetSound("fel")
      end if
      set the loc of sprite aktiv to plats
      if aktiv = 3 then
        tre = 0
      end if
      if aktiv = 4 then
        fyra = 0
      end if
      if aktiv = 5 then
        fem = 0
      end if
      if aktiv = 6 then
        sex = 0
      end if
      if aktiv = 7 then
        sju = 0
      end if
      if aktiv = 8 then
        atta = 0
      end if
      if aktiv = 9 then
        nio = 0
      end if
      if aktiv = 10 then
        tio = 0
      end if
      if aktiv = 13 then
        tretton = 0
      end if
      if aktiv = 14 then
        fjorton = 0
      end if
      if aktiv = 15 then
        femton = 0
      end if
      if aktiv = 16 then
        sexton = 0
      end if
      if aktiv = 17 then
        sjutton = 0
      end if
    else
      if random(4) = 1 then
        puppetSound("bra" & random(3))
      end if
      if aktiv = 3 then
        tre = 1
      end if
      if aktiv = 4 then
        fyra = 1
      end if
      if aktiv = 5 then
        fem = 1
      end if
      if aktiv = 6 then
        sex = 1
      end if
      if aktiv = 7 then
        sju = 1
      end if
      if aktiv = 8 then
        atta = 1
      end if
      if aktiv = 9 then
        nio = 1
      end if
      if aktiv = 10 then
        tio = 1
      end if
      if aktiv = 13 then
        tretton = 1
      end if
      if aktiv = 14 then
        fjorton = 1
      end if
      if aktiv = 15 then
        femton = 1
      end if
      if aktiv = 16 then
        sexton = 1
      end if
      if aktiv = 17 then
        sjutton = 1
      end if
    end if
    if (tre = 1) and (fyra = 1) and (fem = 1) and (sex = 1) and (sju = 1) and (atta = 1) and (nio = 1) and (tio = 1) and (tretton = 1) and (fjorton = 1) and (femton = 1) and (sexton = 1) and (sjutton = 1) then
      puppetSound("klart.aif")
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
