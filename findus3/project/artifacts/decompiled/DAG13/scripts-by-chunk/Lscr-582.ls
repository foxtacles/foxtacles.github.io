on Wait tid
  startTimer()
  repeat while the timer < tid
    nothing()
  end repeat
end

on snurra_upp_brickor
  gron3 = the number of member "gršn3"
  repeat with c = 3 to 10
    fl_puppets_on(c, c)
    set the castNum of sprite c to gron3
    repeat with b = 1 to 2
      fl_visible_on(c, c)
      set the castNum of sprite c to the castNum of sprite c - 1
      puppetSound("CHIP")
      updateStage()
      Wait(3)
    end repeat
  end repeat
  gul3 = the number of member "gul3"
  repeat with c = 26 to 33
    fl_puppets_on(c, c)
    set the castNum of sprite c to gul3
    repeat with b = 1 to 2
      fl_visible_on(c, c)
      set the castNum of sprite c to the castNum of sprite c - 1
      puppetSound("CHIP")
      updateStage()
      Wait(3)
    end repeat
  end repeat
end

on init_memory_lek
  global glmem_cast, glmem_spr, glmem_spr2, glratt_cast, gvand_kort, gant_forsok, gant_klick, gant_par, gpar_dummy
  glmem_cast = []
  glmem_spr = []
  glmem_spr2 = []
  glbok_spr = []
  fl_puppets_off(3, 10)
  fl_puppets_off(26, 33)
  fl_visible_off(14, 21)
  fl_visible_off(37, 44)
  fl_puppets_off(1, 1)
  pek_cursor(3, 10)
  pek_cursor(26, 33)
  gant_forsok = 0
  gant_klick = 0
  gant_par = 0
  gvand_kort = 0
end

on valj_memory_brickor
  global gmem_cast, glmem_cast, glant_mem_cast, gmem_spr, glmem_spr, glant_mem_spr, glmem_spr2, glant_mem_spr2, gNIV_castV, gNIV_castH
  fl_visible_off(14, 21)
  fl_puppets_on(14, 21)
  fl_visible_off(37, 44)
  fl_puppets_on(37, 44)
  fl_puppets_on(3, 10)
  fl_puppets_on(26, 33)
  fl_puppets_on(1, 1)
  repeat with n = 1 to 8
    z = random(20)
    Wait(z)
    glant_mem_cast = count(glmem_cast)
    gmem_cast = random(8)
    X = 0
    repeat while X < glant_mem_cast
      X = X + 1
      if getAt(glmem_cast, X) = gmem_cast then
        X = 0
        gmem_cast = random(8)
      end if
    end repeat
    addAt(glmem_cast, glant_mem_cast + 1, gmem_cast)
    glant_mem_cast = count(glmem_cast)
    glant_mem_spr = count(glmem_spr)
    gmem_spr = random(8)
    Y = 0
    repeat while Y < glant_mem_spr
      Y = Y + 1
      if getAt(glmem_spr, Y) = gmem_spr then
        Y = 0
        gmem_spr = random(8)
      end if
    end repeat
    addAt(glmem_spr, glant_mem_spr + 1, gmem_spr)
    glant_mem_spr = count(glmem_spr)
    set the castNum of sprite (13 + gmem_spr) to gNIV_castV + gmem_cast
    updateStage()
    glant_mem_spr2 = count(glmem_spr2)
    gmem_spr = random(8)
    Y = 0
    repeat while Y < glant_mem_spr2
      Y = Y + 1
      if getAt(glmem_spr2, Y) = gmem_spr then
        Y = 0
        gmem_spr = random(8)
      end if
    end repeat
    addAt(glmem_spr2, glant_mem_spr2 + 1, gmem_spr)
    glant_mem_spr2 = count(glmem_spr2)
    set the castNum of sprite (36 + gmem_spr) to gNIV_castH + gmem_cast
    updateStage()
  end repeat
end

on kolla_mem
  global gklick_mem, gklick_mem1, gant_klick, gMK, gvand_kort, gant_forsok, gant_par, gpar_cast1, gpar_dummy
  if (gant_klick = 0) and (the clickOn > 10) then
    exit
  end if
  if gvand_kort = 1 then
    set the visible of sprite (gklick_mem + 11) to 0
    set the visible of sprite (gklick_mem1 + 11) to 0
    repeat with b = 1 to 3
      set the castNum of sprite gklick_mem to the castNum of sprite gklick_mem - 1
      updateStage()
      Wait(3)
    end repeat
    repeat with b = 1 to 3
      set the castNum of sprite gklick_mem1 to the castNum of sprite gklick_mem1 - 1
      updateStage()
      Wait(3)
    end repeat
    gvand_kort = 0
  end if
  repeat with i = 1 to 1
    gklick_mem = the clickOn
    if gant_klick = 1 then
      if gklick_mem = gklick_mem1 then
        beep()
        exit
      end if
      if abs(gklick_mem1 - gklick_mem) < 11 then
        beep()
        exit
      end if
    end if
    gant_klick = gant_klick + 1
    repeat with b = 1 to 3
      set the castNum of sprite gklick_mem to the castNum of sprite gklick_mem + 1
      updateStage()
      Wait(3)
    end repeat
    set the visible of sprite (gklick_mem + 11) to 1
    puppetSound("CHIP")
    updateStage()
    repeat while soundBusy(1)
      nothing()
    end repeat
    if the memberNum of sprite (gklick_mem + 11) = 67 then
      puppetSound(1, "hon" & random(3))
    end if
    if the memberNum of sprite (gklick_mem + 11) = 87 then
      puppetSound(1, "hon" & random(3))
    end if
    updateStage()
    z = the castNum of sprite (gklick_mem + 11)
    if gant_klick = 2 then
      if ((z - gpar_cast1) = 20) or ((gpar_cast1 - z) = 20) then
        puppetSound(1, "Bra_M.aif")
        if random(4) = 2 then
          repeat while soundBusy(1)
            if the mouseDown then
              exit repeat
            end if
          end repeat
          puppetSound("riktigt")
        end if
        gant_par = gant_par + 1
        set the visible of sprite gklick_mem to 0
        set the visible of sprite gklick_mem1 to 0
        set the cursor of sprite gklick_mem to 0
        set the cursor of sprite gklick_mem1 to 0
        set the visible of sprite (gklick_mem + 11) to 0
        set the visible of sprite (gklick_mem1 + 11) to 0
        set the castNum of sprite gklick_mem to the castNum of sprite gklick_mem - 1
        set the castNum of sprite gklick_mem1 to the castNum of sprite gklick_mem1 - 1
      else
        gant_forsok = gant_forsok + 1
        if random(3) = 1 then
          puppetSound("fel")
        end if
        updateStage()
        gvand_kort = 1
      end if
      gant_klick = 0
      next repeat
    end if
    gpar_cast1 = z
    gklick_mem1 = gklick_mem
  end repeat
  if gant_par = 8 then
    Wait(30)
    updateStage()
    repeat while soundBusy(1)
      nothing()
    end repeat
    fl_puppets_off(1, 45)
    updateStage()
    fl_visible_on(1, 45)
    set the volume of sound 2 to 0
    puppetSound("klart")
    go("MEMORY_KLARAT")
  end if
end

on fl_visible_on first, last
  repeat with X = first to last
    set the visible of sprite X to 1
  end repeat
end

on fl_visible_off first, last
  repeat with X = first to last
    set the visible of sprite X to 0
  end repeat
end

on nolla_puppets
  repeat with X = 1 to 45
    if (X = 42) or (X = 45) or (X = 44) then
      nothing()
      next repeat
    end if
    puppetSprite(X, 0)
  end repeat
  updateStage()
end

on puppets_on
  repeat with X = 17 to 27
    puppetSprite(X, 1)
  end repeat
  updateStage()
end

on puppets_off
  repeat with X = 17 to 27
    puppetSprite(X, 0)
  end repeat
  updateStage()
end

on fl_puppets_on first, last
  repeat with X = first to last
    puppetSprite(X, 1)
  end repeat
  updateStage()
end

on fl_puppets_off first, last
  repeat with X = first to last
    puppetSprite(X, 0)
  end repeat
  updateStage()
end

on nolla_cursor first, last
  global ghand_curs
  repeat with X = first to last
    set the cursor of sprite X to 0
  end repeat
end

on pek_cursor first, last
  global gPekcurs
  repeat with X = first to last
    set the cursor of sprite X to [2000, 2001]
  end repeat
end

on nolla_pekcursor first, last
  repeat with X = first to last
    set the cursor of sprite X to 0
  end repeat
end
