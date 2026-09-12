global dag, lucka, open, pos, guilty, decDate, k, ord

on mouseUp
  if (lucka = 1) and (open = 0) then
    openlucka()
  else
    if (lucka = 1) and (open = 1) and (guilty = 1) then
      puppetSprite(15, 0)
      puppetSprite(16, 0)
      cursor(4)
      puppetTransition(10)
      go("vidare")
    end if
  end if
  lucka = 0
end

on exitFrame
  if (the mouseH > 340) and (the mouseH < 377) and (the mouseV > 217) and (the mouseV < 249) then
    if (open = 1) and (dag <> "dag01") then
      stanglucka()
    end if
    if open = 1 then
      if decDate > 0 then
        cursor([33, 36])
      else
        cursor([49, 51])
      end if
    else
      cursor([33, 36])
    end if
    pos = point(358, 233)
    dag = "dag01"
    lucka = 1
    if decDate > 0 then
      guilty = 1
    else
      guilty = 0
    end if
  else
    if (the mouseH > 459) and (the mouseH < 496) and (the mouseV > 175) and (the mouseV < 207) then
      if (open = 1) and (dag <> "dag02") then
        stanglucka()
      end if
      if open = 1 then
        if decDate > 1 then
          cursor([33, 36])
        else
          cursor([49, 51])
        end if
      else
        cursor([33, 36])
      end if
      pos = point(477, 191)
      dag = "dag02"
      lucka = 1
      if decDate > 1 then
        guilty = 1
      else
        guilty = 0
      end if
    else
      if (the mouseH > 368) and (the mouseH < 405) and (the mouseV > 370) and (the mouseV < 402) then
        if (open = 1) and (dag <> "dag03") then
          stanglucka()
        end if
        if open = 1 then
          if decDate > 2 then
            cursor([33, 36])
          else
            cursor([49, 51])
          end if
        else
          cursor([33, 36])
        end if
        pos = point(386, 386)
        dag = "dag03"
        lucka = 1
        if decDate > 2 then
          guilty = 1
        else
          guilty = 0
        end if
      else
        if (the mouseH > 201) and (the mouseH < 238) and (the mouseV > 308) and (the mouseV < 340) then
          if (open = 1) and (dag <> "dag04") then
            stanglucka()
          end if
          if open = 1 then
            if decDate > 3 then
              cursor([33, 36])
            else
              cursor([49, 51])
            end if
          else
            cursor([33, 36])
          end if
          pos = point(219, 324)
          dag = "dag04"
          lucka = 1
          if decDate > 3 then
            guilty = 1
          else
            guilty = 0
          end if
        else
          if (the mouseH > 86) and (the mouseH < 123) and (the mouseV > 337) and (the mouseV < 369) then
            if (open = 1) and (dag <> "dag05") then
              stanglucka()
            end if
            if open = 1 then
              if decDate > 4 then
                cursor([33, 36])
              else
                cursor([49, 51])
              end if
            else
              cursor([33, 36])
            end if
            pos = point(104, 353)
            dag = "dag05"
            lucka = 1
            if decDate > 4 then
              guilty = 1
            else
              guilty = 0
            end if
          else
            if (the mouseH > 287) and (the mouseH < 324) and (the mouseV > 137) and (the mouseV < 169) then
              if (open = 1) and (dag <> "dag06") then
                stanglucka()
              end if
              if open = 1 then
                if decDate > 5 then
                  cursor([33, 36])
                else
                  cursor([49, 51])
                end if
              else
                cursor([33, 36])
              end if
              pos = point(305, 153)
              dag = "dag06"
              lucka = 1
              if decDate > 5 then
                guilty = 1
              else
                guilty = 0
              end if
            else
              if (the mouseH > 321) and (the mouseH < 358) and (the mouseV > 303) and (the mouseV < 335) then
                if (open = 1) and (dag <> "dag07") then
                  stanglucka()
                end if
                if open = 1 then
                  if decDate > 6 then
                    cursor([33, 36])
                  else
                    cursor([49, 51])
                  end if
                else
                  cursor([33, 36])
                end if
                pos = point(339, 319)
                dag = "dag07"
                lucka = 1
                if decDate > 6 then
                  guilty = 1
                else
                  guilty = 0
                end if
              else
                if (the mouseH > 574) and (the mouseH < 611) and (the mouseV > 113) and (the mouseV < 145) then
                  if (open = 1) and (dag <> "dag08") then
                    stanglucka()
                  end if
                  if open = 1 then
                    if decDate > 7 then
                      cursor([33, 36])
                    else
                      cursor([49, 51])
                    end if
                  else
                    cursor([33, 36])
                  end if
                  pos = point(592, 129)
                  dag = "dag08"
                  lucka = 1
                  if decDate > 7 then
                    guilty = 1
                  else
                    guilty = 0
                  end if
                else
                  if (the mouseH > 552) and (the mouseH < 589) and (the mouseV > 331) and (the mouseV < 363) then
                    if (open = 1) and (dag <> "dag09") then
                      stanglucka()
                    end if
                    if open = 1 then
                      if decDate > 8 then
                        cursor([33, 36])
                      else
                        cursor([49, 51])
                      end if
                    else
                      cursor([33, 36])
                    end if
                    pos = point(570, 347)
                    dag = "dag09"
                    lucka = 1
                    if decDate > 8 then
                      guilty = 1
                    else
                      guilty = 0
                    end if
                  else
                    if (the mouseH > 72) and (the mouseH < 109) and (the mouseV > 265) and (the mouseV < 297) then
                      if (open = 1) and (dag <> "dag10") then
                        stanglucka()
                      end if
                      if open = 1 then
                        if decDate > 9 then
                          cursor([33, 36])
                        else
                          cursor([49, 51])
                        end if
                      else
                        cursor([33, 36])
                      end if
                      pos = point(90, 281)
                      dag = "dag10"
                      lucka = 1
                      if decDate > 9 then
                        guilty = 1
                      else
                        guilty = 0
                      end if
                    else
                      if (the mouseH > 209) and (the mouseH < 246) and (the mouseV > 346) and (the mouseV < 378) then
                        if (open = 1) and (dag <> "dag11") then
                          stanglucka()
                        end if
                        if open = 1 then
                          if decDate > 10 then
                            cursor([33, 36])
                          else
                            cursor([49, 51])
                          end if
                        else
                          cursor([33, 36])
                        end if
                        pos = point(227, 362)
                        dag = "dag11"
                        lucka = 1
                        if decDate > 10 then
                          guilty = 1
                        else
                          guilty = 0
                        end if
                      else
                        if (the mouseH > 534) and (the mouseH < 571) and (the mouseV > 250) and (the mouseV < 282) then
                          if (open = 1) and (dag <> "dag12") then
                            stanglucka()
                          end if
                          if open = 1 then
                            if decDate > 11 then
                              cursor([33, 36])
                            else
                              cursor([49, 51])
                            end if
                          else
                            cursor([33, 36])
                          end if
                          pos = point(552, 266)
                          dag = "dag12"
                          lucka = 1
                          if decDate > 11 then
                            guilty = 1
                          else
                            guilty = 0
                          end if
                        else
                          if (the mouseH > 149) and (the mouseH < 186) and (the mouseV > 326) and (the mouseV < 358) then
                            if (open = 1) and (dag <> "dag13") then
                              stanglucka()
                            end if
                            if open = 1 then
                              if decDate > 12 then
                                cursor([33, 36])
                              else
                                cursor([49, 51])
                              end if
                            else
                              cursor([33, 36])
                            end if
                            pos = point(167, 342)
                            dag = "dag13"
                            lucka = 1
                            if decDate > 12 then
                              guilty = 1
                            else
                              guilty = 0
                            end if
                          else
                            if (the mouseH > 29) and (the mouseH < 66) and (the mouseV > 202) and (the mouseV < 234) then
                              if (open = 1) and (dag <> "dag14") then
                                stanglucka()
                              end if
                              if open = 1 then
                                if decDate > 13 then
                                  cursor([33, 36])
                                else
                                  cursor([49, 51])
                                end if
                              else
                                cursor([33, 36])
                              end if
                              pos = point(47, 218)
                              dag = "dag14"
                              lucka = 1
                              if decDate > 13 then
                                guilty = 1
                              else
                                guilty = 0
                              end if
                            else
                              if (the mouseH > 436) and (the mouseH < 473) and (the mouseV > 133) and (the mouseV < 165) then
                                if (open = 1) and (dag <> "dag15") then
                                  stanglucka()
                                end if
                                if open = 1 then
                                  if decDate > 14 then
                                    cursor([33, 36])
                                  else
                                    cursor([49, 51])
                                  end if
                                else
                                  cursor([33, 36])
                                end if
                                pos = point(454, 149)
                                dag = "dag15"
                                lucka = 1
                                if decDate > 14 then
                                  guilty = 1
                                else
                                  guilty = 0
                                end if
                              else
                                if (the mouseH > 589) and (the mouseH < 626) and (the mouseV > 363) and (the mouseV < 395) then
                                  if (open = 1) and (dag <> "dag16") then
                                    stanglucka()
                                  end if
                                  if open = 1 then
                                    if decDate > 15 then
                                      cursor([33, 36])
                                    else
                                      cursor([49, 51])
                                    end if
                                  else
                                    cursor([33, 36])
                                  end if
                                  pos = point(607, 379)
                                  dag = "dag16"
                                  lucka = 1
                                  if decDate > 15 then
                                    guilty = 1
                                  else
                                    guilty = 0
                                  end if
                                else
                                  if (the mouseH > 374) and (the mouseH < 411) and (the mouseV > 304) and (the mouseV < 336) then
                                    if (open = 1) and (dag <> "dag17") then
                                      stanglucka()
                                    end if
                                    if open = 1 then
                                      if decDate > 16 then
                                        cursor([33, 36])
                                      else
                                        cursor([49, 51])
                                      end if
                                    else
                                      cursor([33, 36])
                                    end if
                                    pos = point(392, 320)
                                    dag = "dag17"
                                    lucka = 1
                                    if decDate > 16 then
                                      guilty = 1
                                    else
                                      guilty = 0
                                    end if
                                  else
                                    if (the mouseH > 385) and (the mouseH < 422) and (the mouseV > 167) and (the mouseV < 199) then
                                      if (open = 1) and (dag <> "dag18") then
                                        stanglucka()
                                      end if
                                      if open = 1 then
                                        if decDate > 17 then
                                          cursor([33, 36])
                                        else
                                          cursor([49, 51])
                                        end if
                                      else
                                        cursor([33, 36])
                                      end if
                                      pos = point(403, 183)
                                      dag = "dag18"
                                      lucka = 1
                                      if decDate > 17 then
                                        guilty = 1
                                      else
                                        guilty = 0
                                      end if
                                    else
                                      if (the mouseH > 278) and (the mouseH < 315) and (the mouseV > 278) and (the mouseV < 310) then
                                        if (open = 1) and (dag <> "dag19") then
                                          stanglucka()
                                        end if
                                        if open = 1 then
                                          if decDate > 18 then
                                            cursor([33, 36])
                                          else
                                            cursor([49, 51])
                                          end if
                                        else
                                          cursor([33, 36])
                                        end if
                                        pos = point(296, 294)
                                        dag = "dag19"
                                        lucka = 1
                                        if decDate > 18 then
                                          guilty = 1
                                        else
                                          guilty = 0
                                        end if
                                      else
                                        if (the mouseH > 373) and (the mouseH < 410) and (the mouseV > 108) and (the mouseV < 140) then
                                          if (open = 1) and (dag <> "dag20") then
                                            stanglucka()
                                          end if
                                          if open = 1 then
                                            if decDate > 19 then
                                              cursor([33, 36])
                                            else
                                              cursor([49, 51])
                                            end if
                                          else
                                            cursor([33, 36])
                                          end if
                                          pos = point(391, 124)
                                          dag = "dag20"
                                          lucka = 1
                                          if decDate > 19 then
                                            guilty = 1
                                          else
                                            guilty = 0
                                          end if
                                        else
                                          if (the mouseH > 534) and (the mouseH < 571) and (the mouseV > 145) and (the mouseV < 177) then
                                            if (open = 1) and (dag <> "dag21") then
                                              stanglucka()
                                            end if
                                            if open = 1 then
                                              if decDate > 20 then
                                                cursor([33, 36])
                                              else
                                                cursor([49, 51])
                                              end if
                                            else
                                              cursor([33, 36])
                                            end if
                                            pos = point(552, 161)
                                            dag = "dag21"
                                            lucka = 1
                                            if decDate > 20 then
                                              guilty = 1
                                            else
                                              guilty = 0
                                            end if
                                          else
                                            if (the mouseH > 447) and (the mouseH < 484) and (the mouseV > 294) and (the mouseV < 326) then
                                              if (open = 1) and (dag <> "dag22") then
                                                stanglucka()
                                              end if
                                              if open = 1 then
                                                if decDate > 21 then
                                                  cursor([33, 36])
                                                else
                                                  cursor([49, 51])
                                                end if
                                              else
                                                cursor([33, 36])
                                              end if
                                              pos = point(465, 310)
                                              dag = "dag22"
                                              lucka = 1
                                              if decDate > 21 then
                                                guilty = 1
                                              else
                                                guilty = 0
                                              end if
                                            else
                                              if (the mouseH > 406) and (the mouseH < 443) and (the mouseV > 38) and (the mouseV < 70) then
                                                if (open = 1) and (dag <> "dag23") then
                                                  stanglucka()
                                                end if
                                                if open = 1 then
                                                  if decDate > 22 then
                                                    cursor([33, 36])
                                                  else
                                                    cursor([49, 51])
                                                  end if
                                                else
                                                  cursor([33, 36])
                                                end if
                                                pos = point(424, 54)
                                                dag = "dag23"
                                                lucka = 1
                                                if decDate > 22 then
                                                  guilty = 1
                                                else
                                                  guilty = 0
                                                end if
                                              else
                                                if (the mouseH > 541) and (the mouseH < 578) and (the mouseV > 16) and (the mouseV < 48) then
                                                  if (open = 1) and (dag <> "dag24") then
                                                    stanglucka()
                                                  end if
                                                  if open = 1 then
                                                    if decDate > 23 then
                                                      cursor([33, 36])
                                                    else
                                                      cursor([49, 51])
                                                    end if
                                                  else
                                                    cursor([33, 36])
                                                  end if
                                                  pos = point(559, 32)
                                                  dag = "dag24"
                                                  lucka = 1
                                                  if decDate > 23 then
                                                    guilty = 1
                                                  else
                                                    guilty = 0
                                                  end if
                                                else
                                                  if rollOver(3) then
                                                    if open = 1 then
                                                      stanglucka()
                                                    end if
                                                    cursor([33, 36])
                                                    puppetSprite(3, 1)
                                                    set the memberNum of sprite 3 to member(49, "shared")
                                                    sprite(3).visible = 1
                                                    updateStage()
                                                    repeat while rollOver(3)
                                                      sprite(3).visible = 1
                                                      updateStage()
                                                      if the mouseDown then
                                                        repeat while the mouseDown
                                                          if rollOver(3) then
                                                            sprite(3).visible = 1
                                                            cursor([33, 36])
                                                          else
                                                            sprite(3).visible = 0
                                                            cursor(0)
                                                          end if
                                                          updateStage()
                                                        end repeat
                                                        if rollOver(3) then
                                                          go("volym")
                                                        end if
                                                        cursor(0)
                                                      end if
                                                    end repeat
                                                    sprite(3).visible = 0
                                                    puppetSprite(3, 0)
                                                    updateStage()
                                                  else
                                                    if rollOver(4) then
                                                      if open = 1 then
                                                        stanglucka()
                                                      end if
                                                      cursor([33, 36])
                                                      puppetSprite(4, 1)
                                                      set the memberNum of sprite 4 to member(48, "shared")
                                                      sprite(4).visible = 1
                                                      updateStage()
                                                      repeat while rollOver(4)
                                                        if the mouseDown then
                                                          puppetSprite(4, 0)
                                                          repeat while the mouseDown
                                                            if rollOver(4) then
                                                              sprite(4).visible = 1
                                                              cursor([33, 36])
                                                            else
                                                              sprite(4).visible = 0
                                                              cursor(0)
                                                            end if
                                                            updateStage()
                                                          end repeat
                                                          if rollOver(4) then
                                                            i = 51
                                                            repeat while i <= (decDate + 50)
                                                              sprite(i).visible = 1
                                                              i = i + 1
                                                              updateStage()
                                                            end repeat
                                                            sprite(4).visible = 0
                                                            go("kista")
                                                          end if
                                                        end if
                                                      end repeat
                                                      sprite(4).visible = 0
                                                      puppetSprite(4, 0)
                                                      updateStage()
                                                    else
                                                      if open = 1 then
                                                        stanglucka()
                                                      end if
                                                      lucka = 0
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
  if the key <> k then
    k = the key
    put k after ord
    if ord = "tomte" then
      sprite(48).visible = not sprite(48).visible
      ord = EMPTY
    end if
  end if
  updateStage()
  go(the frame)
end
