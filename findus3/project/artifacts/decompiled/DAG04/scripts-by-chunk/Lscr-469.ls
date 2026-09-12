on exitFrame
  set the visible of sprite 60 to 0
  puppetSound("uppror")
  unloadMember(member(2))
  updateStage()
  vanta = the ticks
  repeat while the ticks < (vanta + 600)
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
            exit
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
              bak = 1
              exit repeat
            end if
          end if
        end repeat
        set the visible of sprite 4 to 0
        updateStage()
      else
        if rollOver(1) then
          cursor([15, 16])
          if the mouseDown then
            repeat while the mouseDown
            end repeat
            if rollOver(1) then
              exit repeat
            end if
          end if
        else
          cursor(0)
        end if
      end if
    end if
    if bak = 1 then
      go(4)
      exit
    end if
    go(the frame)
  end repeat
  go("start")
end
