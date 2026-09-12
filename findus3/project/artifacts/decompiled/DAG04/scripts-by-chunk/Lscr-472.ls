global honIntervall, klubba, tupp, level, ax

on exitFrame
  preloadMember(member(66))
  preloadMember(member(70))
  puppetSprite(45, 0)
  repeat with channel = 36 to 49
    set the visible of sprite channel to 0
  end repeat
  honIntervall = 1
  klubba = 42
  tupp = 35
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
          level = 60
          ax = 5
          go(5)
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
          if rollOver(4) then
            level = 120
            ax = 10
            go(5)
          end if
        end if
      end repeat
      set the visible of sprite 4 to 0
      updateStage()
    else
      if rollOver(5) then
        cursor([15, 16])
        set the visible of sprite 60 to 0
        updateStage()
        repeat while rollOver(5)
          set the visible of sprite 5 to 1
          updateStage()
          if the mouseDown then
            repeat while the mouseDown
              if rollOver(5) then
                set the visible of sprite 5 to 1
                cursor([15, 16])
              else
                set the visible of sprite 5 to 0
                cursor(0)
              end if
              updateStage()
            end repeat
            if rollOver(5) then
              level = 240
              ax = 12
              go(5)
            end if
          end if
        end repeat
        set the visible of sprite 5 to 0
        updateStage()
      else
        cursor(0)
      end if
    end if
  end if
  go(the frame)
end
