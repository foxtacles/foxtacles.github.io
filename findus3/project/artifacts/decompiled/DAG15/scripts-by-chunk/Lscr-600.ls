on mustest
  if rollOver(40) then
    cursor([61, 62])
    set the visible of sprite 40 to 1
    updateStage()
    if the mouseDown then
      repeat while the mouseDown
        if rollOver(40) then
          set the visible of sprite 40 to 1
          cursor([61, 62])
        else
          set the visible of sprite 40 to 0
          cursor(0)
        end if
        updateStage()
      end repeat
      if rollOver(40) then
        set the visible of sprite 40 to 0
        cursor(4)
        puppetTransition(10)
        go("vidare")
      end if
    end if
    set the visible of sprite 41 to 0
    updateStage()
  else
    if rollOver(41) then
      cursor([61, 62])
      set the visible of sprite 41 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(41) then
            set the visible of sprite 41 to 1
            cursor([61, 62])
          else
            set the visible of sprite 41 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(41) then
          cursor(200)
          set the visible of sprite 41 to 0
          updateStage()
          initHopp()
          exit
        end if
      end if
      set the visible of sprite 40 to 0
      updateStage()
    else
      set the visible of sprite 40 to 0
      set the visible of sprite 41 to 0
    end if
  end if
end
