on exitFrame
  if rollOver(3) then
    cursor([15, 16])
    set the visible of sprite 60 to 0
    updateStage()
    repeat while rollOver(3)
      set the visible of sprite 3 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(3) then
            set the visible of sprite 3 to 1
            cursor([15, 16])
          else
            set the visible of sprite 3 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(3) then
          puppetTransition(10)
          go("vidare")
        end if
      end if
    end repeat
    set the visible of sprite 3 to 0
    updateStage()
  else
    if rollOver(4) then
      cursor([15, 16])
      set the visible of sprite 60 to 0
      updateStage()
      repeat while rollOver(4)
        set the visible of sprite 4 to 1
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(4) then
              set the visible of sprite 4 to 1
              cursor([15, 16])
            else
              set the visible of sprite 4 to 0
              cursor(0)
            end if
            updateStage()
          end repeat
          set the visible of sprite 4 to 0
          if rollOver(4) then
            go(4)
          end if
        end if
      end repeat
      set the visible of sprite 4 to 0
      updateStage()
    else
      cursor(0)
    end if
  end if
  go(the frame)
end
