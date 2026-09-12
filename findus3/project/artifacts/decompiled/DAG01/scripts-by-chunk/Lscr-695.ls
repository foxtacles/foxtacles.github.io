on rollKnapp
  if rollOver(40) then
    cursor([30, 31])
    if the shiftDown or the controlDown then
      exit
    end if
    set the visible of sprite 40 to 1
    updateStage()
    if the mouseDown then
      repeat while the mouseDown
        if rollOver(40) then
          set the visible of sprite 40 to 1
          cursor([30, 31])
        else
          set the visible of sprite 40 to 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(40) then
        puppetSound(0)
        set the visible of sprite 40 to 0
        puppetTransition(10)
        go("vidare")
        abort()
      end if
    end if
    set the visible of sprite 41 to 0
    updateStage()
  else
    if rollOver(41) then
      cursor([30, 31])
      if the shiftDown or the controlDown then
        exit
      end if
      set the visible of sprite 41 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(41) then
            set the visible of sprite 41 to 1
            cursor([30, 31])
          else
            set the visible of sprite 41 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(41) then
          puppetSound(0)
          set the visible of sprite 45 to 0
          set the visible of sprite 41 to 0
          puppetSprite(10, 0)
          put EMPTY into field "tid_field"
          go("startgame")
          abort()
        end if
      end if
      set the visible of sprite 40 to 0
      updateStage()
    else
      set the visible of sprite 40 to 0
      set the visible of sprite 41 to 0
      cursor(0)
    end if
  end if
end
