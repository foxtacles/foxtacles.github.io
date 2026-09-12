on init
  global spNumLina, horPosLina, vertPosLina, spnumfisk, spNumSp‡, spNumPannan, l‚ngd, step, maxvinkel, i, sp‡Pos, l‚ngdinc, vinkelDec, spNumKantV, spNumKantH, spNumPannMask, linOffsetH, linOffsetV
  spNumSp‡ = 9
  spNumLina = 10
  spnumfisk = 11
  spNumPannan = 8
  spNumKantV = 6
  spNumKantH = 7
  spNumPannMask = 12
  sp‡Pos = 6
  linOffsetH = -7
  linOffsetV = 3
  horPosLina = the right of sprite spNumSp‡
  vertPosLina = the top of sprite spNumSp‡
  l‚ngd = 10
  step = float(0.02)
  maxvinkel = float(0)
  i = 0
  l‚ngdinc = 0.40000000000000002
  vinkelDec = 0.14999999999999999
  puppetSprite(spNumLina, 1)
  puppetSprite(spnumfisk, 1)
  puppetSprite(spNumSp‡, 1)
  sprite(spnumfisk).visible = 1
end

on fixaspo
  global horPosLina, vertPosLina, l‚ngd, maxvinkel, sp‡Pos, spNumSp‡, dx, dy, linOffsetH, linOffsetV
  case the keyCode of
    126:
      set the volume of sound 1 to 100
      puppetSound(1, "linain")
      if l‚ngd > 10 then
        l‚ngd = l‚ngd - 5
      end if
      if maxvinkel > 1 then
        maxvinkel = maxvinkel - 1
      end if
      nyPosLina()
      ritaLina(dx, dy)
      updateStage()
    125:
      set the volume of sound 1 to 100
      puppetSound(1, "linaut")
      if l‚ngd < 400 then
        l‚ngd = l‚ngd + 10
      end if
      if maxvinkel < 45 then
        maxvinkel = maxvinkel + (random(2) * 2)
      end if
      nyPosLina()
      ritaLina(dx, dy)
      updateStage()
    124:
      if sp‡Pos > 1 then
        sp‡Pos = sp‡Pos - 1
        set the member of sprite spNumSp‡ to member("spö" & sp‡Pos)
        updateStage()
        case sp‡Pos of
          1:
            linOffsetV = 35
          2:
            linOffsetV = 14
          3:
            linOffsetV = 5
          4:
            linOffsetV = 3
          5:
            linOffsetV = 3
          6:
            linOffsetV = 3
          7:
            linOffsetV = 3
          8:
            linOffsetV = 3
          9:
            linOffsetV = 3
          10:
            linOffsetV = 3
          11:
            linOffsetV = 3
        end case
        horPosLina = the right of sprite spNumSp‡ + linOffsetH
        vertPosLina = the top of sprite spNumSp‡ + linOffsetV
        nyPosLina()
        ritaLina(dx, dy)
        updateStage()
      end if
      if maxvinkel < 45 then
        maxvinkel = maxvinkel + (random(10) * 2)
      end if
    123:
      if sp‡Pos < 11 then
        sp‡Pos = sp‡Pos + 1
        set the member of sprite spNumSp‡ to member("spö" & sp‡Pos)
        updateStage()
        case sp‡Pos of
          1:
            linOffsetV = 35
          2:
            linOffsetV = 14
          3:
            linOffsetV = 5
          4:
            linOffsetV = 3
          5:
            linOffsetV = 3
          6:
            linOffsetV = 3
          7:
            linOffsetV = 3
          8:
            linOffsetV = 3
          9:
            linOffsetV = 3
          10:
            linOffsetV = 3
          11:
            linOffsetV = 3
        end case
        horPosLina = the right of sprite spNumSp‡ + linOffsetH
        vertPosLina = the top of sprite spNumSp‡ + linOffsetV
        nyPosLina()
        ritaLina(dx, dy)
        updateStage()
      end if
      if maxvinkel < 45 then
        maxvinkel = maxvinkel + (random(10) * 2)
      end if
  end case
end

on nyPosLina
  global l‚ngd, step, maxvinkel, i, dx, dy, vinkeln, l‚ngdinc, vinkelDec
  vinkeln = maxvinkel * sin(PI * 2 * i) * (PI / 180)
  dx = l‚ngd * cos(vinkeln)
  dy = l‚ngd * sin(vinkeln)
  if vinkeln < maxvinkel then
    i = i + step
  else
    step = -step
  end if
  if maxvinkel > 1 then
    maxvinkel = maxvinkel - vinkelDec
  end if
  if l‚ngd < 400 then
    l‚ngd = l‚ngd + l‚ngdinc
  end if
end

on ritaLina vert, hor
  global spNumLina, horPosLina, vertPosLina, spnumfisk, vinkeln, l‚ngd
  vinkel = abs(vinkeln * (180 / PI))
  fiskcast = the member of sprite spnumfisk
  if hor >= 0 then
    if vinkel < 15 then
      fiskcast = "fisk"
    else
      if vinkel < 30 then
        fiskcast = "fisk.h20"
      else
        if vinkel < 45 then
          fiskcast = "fisk.h40"
        else
          if vinkel < 100 then
            fiskcast = "fisk.h60"
          end if
        end if
      end if
    end if
    if l‚ngd > 40 then
      set the member of sprite spnumfisk to member(fiskcast)
    else
      set the member of sprite spnumfisk to member("fisk")
    end if
  end if
  if hor < 0 then
    if vinkel < 15 then
      fiskcast = "fisk"
    else
      if vinkel < 30 then
        fiskcast = "fisk.v20"
      else
        if vinkel < 45 then
          fiskcast = "fisk.v40"
        else
          if vinkel < 100 then
            fiskcast = "fisk.v60"
          end if
        end if
      end if
    end if
    if l‚ngd > 40 then
      set the member of sprite spnumfisk to member(fiskcast)
    else
      set the member of sprite spnumfisk to member("fisk")
    end if
  end if
  if hor < 0 then
    if hor <= -5 then
      set the member of sprite spNumLina to member("lina v")
    else
      set the member of sprite spNumLina to member("lina rak")
      hor = -1
    end if
    left = horPosLina + hor
    top = vertPosLina
    right = horPosLina
    bottom = vertPosLina + vert
    spriteBox(spNumLina, left, top, right, bottom)
    set the locH of sprite spnumfisk to left
    set the locV of sprite spnumfisk to bottom
  end if
  if hor > 0 then
    if hor >= 5 then
      set the member of sprite spNumLina to member("lina h")
    else
      set the member of sprite spNumLina to member("lina rak")
      hor = 1
    end if
    left = horPosLina
    top = vertPosLina
    right = horPosLina + hor
    bottom = vertPosLina + vert
    spriteBox(spNumLina, left, top, right, bottom)
    set the locH of sprite spnumfisk to right
    set the locV of sprite spnumfisk to bottom
  end if
  updateStage()
end

on initpannan
  global spNumPannan, pannRect, pannansMitt, spNumKantV, spNumKantH, spNumPannMask, vKantRect, hKantrect
  puppetSprite(spNumPannan, 1)
  puppetSprite(spNumKantV, 1)
  puppetSprite(spNumKantH, 1)
  puppetSprite(spNumPannMask, 1)
  set the locV of sprite spNumPannan to 430
  set the locV of sprite spNumKantV to 430
  set the locV of sprite spNumKantH to 430
  set the locV of sprite spNumPannMask to 430
  set the locH of sprite spNumPannan to 275 + random(150)
  set the locH of sprite spNumKantV to the locH of sprite spNumPannan
  set the locH of sprite spNumKantH to the locH of sprite spNumPannan
  set the locH of sprite spNumPannMask to the locH of sprite spNumPannan
  updateStage()
  pannRect = the rect of sprite spNumPannan
  vKantRect = the rect of sprite spNumKantV
  hKantrect = the rect of sprite spNumKantH
  pannansMitt = pannRect.top + ((pannRect.bottom - pannRect.top) / 2)
end

on kollaPannan
  global spnumfisk, pannRect, pannansMitt, vKantRect, hKantrect
  fiskrect = the rect of sprite spnumfisk
  safe = 5
  if fiskrect.bottom > pannansMitt then
    if (fiskrect.left > (pannRect.left - safe)) and (fiskrect.right < (pannRect.right + safe)) then
      fiskOK()
      go("feedback")
      exit
    end if
  end if
  if fiskrect.bottom > 435 then
    if (fiskrect.right < vKantRect.left) or (fiskrect.left > hKantrect.right) then
      fiskMissBord()
      go("feedback")
      exit
    end if
  end if
  if fiskrect.bottom > pannansMitt then
    if (fiskrect.right > vKantRect.left) and (fiskrect.left < pannRect.left) then
      fiskMissV()
      go("feedback")
      exit
    end if
    if (fiskrect.left < hKantrect.right) and (fiskrect.right > pannRect.right) then
      fiskMissH()
      go("feedback")
      exit
    end if
  end if
end

on fiskMissV
  global horPosLina, vertPosLina, spnumfisk, pannRect, resultat, spNumLina
  set the volume of sound 1 to 255
  puppetSound(1, "kanten")
  set the locH of sprite spnumfisk to pannRect.left - 25
  set the locV of sprite spnumfisk to pannRect.top - 30
  if horPosLina < the locH of sprite spnumfisk then
    left = horPosLina
    right = the locH of sprite spnumfisk
    set the member of sprite spNumLina to member("lina h")
  else
    if horPosLina > the locH of sprite spnumfisk then
      right = horPosLina
      left = the locH of sprite spnumfisk
      set the member of sprite spNumLina to member("lina v")
    end if
  end if
  top = vertPosLina
  bottom = the locV of sprite spnumfisk
  if left = right then
    right = right + 1
  end if
  spriteBox(spNumLina, left, top, right, bottom)
  updateStage()
  resultat = "Heltorsk!"
end

on fiskMissH
  global horPosLina, vertPosLina, spnumfisk, pannRect, resultat, spNumLina
  set the volume of sound 1 to 255
  puppetSound(1, "kanten")
  set the locH of sprite spnumfisk to pannRect.right + 25
  set the locV of sprite spnumfisk to pannRect.top - 30
  if horPosLina < the locH of sprite spnumfisk then
    left = horPosLina
    right = the locH of sprite spnumfisk
    set the member of sprite spNumLina to member("lina h")
  else
    if horPosLina > the locH of sprite spnumfisk then
      right = horPosLina
      left = the locH of sprite spnumfisk
      set the member of sprite spNumLina to member("lina v")
    end if
  end if
  top = vertPosLina
  bottom = the locV of sprite spnumfisk
  if left = right then
    right = right + 1
  end if
  spriteBox(spNumLina, left, top, right, bottom)
  updateStage()
  resultat = "Heltorsk!"
end

on fiskOK
  global horPosLina, vertPosLina, spnumfisk, pannRect, resultat, spNumLina
  set the volume of sound 1 to 255
  puppetSound(1, "ipannan")
  set the locH of sprite spnumfisk to pannRect.right - 30
  set the locV of sprite spnumfisk to pannRect.top - 30
  if horPosLina < the locH of sprite spnumfisk then
    left = horPosLina
    right = the locH of sprite spnumfisk
    set the member of sprite spNumLina to member("lina h")
  else
    if horPosLina > the locH of sprite spnumfisk then
      right = horPosLina
      left = the locH of sprite spnumfisk
      set the member of sprite spNumLina to member("lina v")
    end if
  end if
  top = vertPosLina
  bottom = the locV of sprite spnumfisk
  if left = right then
    right = right + 1
  end if
  spriteBox(spNumLina, left, top, right, bottom)
  updateStage()
  resultat = "Fina fisken!"
end

on fiskMissBord
  global resultat
  set the volume of sound 1 to 255
  puppetSound(1, "bordet")
  put "Bordet"
  resultat = "Bottennapp!"
end

on feedback
  global resultat
  if resultat = "Fina fisken!" then
    go("bra")
  else
    go("miss")
  end if
end

on kollaKanten
  global spnumfisk, step, maxvinkel, dx, dy, vinkelDec, resultat
  fiskrect = the rect of sprite spnumfisk
  if fiskrect.right > 600 then
    set the volume of sound 1 to 255
    sound stop 2
    puppetSound(1, "fiskut")
    sprite(spnumfisk).visible = 0
    vinkelDec = 0.5
    updateStage()
    repeat while maxvinkel > 1
      nyPosLina()
      ritaLina(dx, dy)
    end repeat
    resultat = "Flygfisk!"
    go("feedback")
  end if
end

on svischljud
  global maxvinkel, vinkeln
  vink = abs(vinkeln * (180 / PI))
  if (vink < 10) and not soundBusy(1) and (maxvinkel > 15) then
    set the volume of sound 1 to integer(maxvinkel * 4)
    puppetSound(1, "schwung")
    updateStage()
  end if
end
