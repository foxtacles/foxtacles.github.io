on exitFrame
  if rollOver(23) then
    cursor([98, 99])
    repeat while rollOver(23)
      set the visible of sprite 23 to 1
      updateStage()
      if the mouseDown then
        repeat while the mouseDown
          if rollOver(23) then
            set the visible of sprite 23 to 1
            cursor([98, 99])
          else
            set the visible of sprite 23 to 0
            cursor(0)
          end if
          updateStage()
        end repeat
        if rollOver(23) then
          set the visible of sprite 23 to 0
          puppetSprite(12, 0)
          puppetTransition(10)
          go("vidare")
        end if
      end if
    end repeat
    set the visible of sprite 23 to 0
    updateStage()
  else
    if rollOver(24) then
      cursor([98, 99])
      repeat while rollOver(24)
        set the visible of sprite 24 to 1
        updateStage()
        if the mouseDown then
          repeat while the mouseDown
            if rollOver(24) then
              set the visible of sprite 24 to 1
              cursor([98, 99])
            else
              set the visible of sprite 24 to 0
              cursor(0)
            end if
            updateStage()
          end repeat
          if rollOver(24) then
            set the visible of sprite 24 to 0
            cursor(4)
            go("main")
          end if
        end if
      end repeat
      set the visible of sprite 24 to 0
      updateStage()
    else
      cursor(0)
    end if
  end if
  go(the frame)
end
