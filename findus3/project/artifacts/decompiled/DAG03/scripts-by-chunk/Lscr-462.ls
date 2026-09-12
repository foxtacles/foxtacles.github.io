on exitFrame
  global resultat
  set the visible of sprite 38 to 0
  set the visible of sprite 39 to 0
  set the visible of sprite 40 to 0
  puppetSprite(44, 1)
  puppetSprite(45, 1)
  puppetSprite(46, 1)
  resultat = the timer / 60
  minresultat = resultat / 60
  sekresultat = resultat - (minresultat * 60)
  put minresultat & " min " & sekresultat & " sek " into field 56
  objekt = the mouseCast
  listTal = objekt - 1
  if rollOver(48) then
    cursor([61, 62])
    repeat while rollOver(48)
      set the visible of sprite 48 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(48) then
            set the visible of sprite 48 to 1
            cursor([61, 62])
          else
            set the visible of sprite 48 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(48) then
          set the visible of sprite 48 to 0
          puppetTransition(10)
          go("vidare")
        end if
      end if
    end repeat
    set the visible of sprite 48 to 0
    updateStage()
  else
    if rollOver(49) then
      cursor([61, 62])
      repeat while rollOver(49)
        set the visible of sprite 49 to 1
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(49) then
              set the visible of sprite 49 to 1
              cursor([61, 62])
            else
              set the visible of sprite 49 to 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(49) then
            set the visible of sprite 49 to 0
            startTimer()
            borjaom()
            go("huvud")
            exit
          end if
        end if
      end repeat
      set the visible of sprite 49 to 0
      updateStage()
    else
      if (objekt >= the memberNum of sprite 10) and (objekt <= the memberNum of sprite 33) and (listTal < 25) then
        if getAt(slumplistan, listTal) <> 0 then
          cursor([61, 62])
        end if
      else
        cursor(0)
      end if
    end if
  end if
  go(the frame)
end
