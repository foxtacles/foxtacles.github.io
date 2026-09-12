global gTileSprite, gGameSize, gEmptyPos, gGameTime

on mouseUp
  sp = the clickOn
  if (sp >= gTileSprite) and (sp < (gTileSprite + (gGameSize * gGameSize))) then
    sp = sp - gTileSprite + 1
    put "sp=" & sp
    if movetile(sp) then
      put "OK!"
      render_game()
      if check_completed() then
        put gGameTime & " sekunder." into field "result_field"
        sound stop 2
        puppetSound("klart.aif")
        go("gamecompleted")
      end if
    else
      puppetSound(1, 33)
      put "NOPE!"
    end if
  end if
end
