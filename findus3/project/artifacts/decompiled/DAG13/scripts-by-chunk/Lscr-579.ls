on exitFrame
  repeat while soundBusy(2)
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
            puppetTransition(10)
            go("kalender")
            exit
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
              go("ovn4.1")
              exit
            end if
          end if
        end repeat
        set the visible of sprite 24 to 0
        updateStage()
      else
        cursor(0)
        if the mouseDown then
          repeat while the mouseDown
            nothing()
          end repeat
          go("HEM")
          exit
        end if
      end if
    end if
    if not soundBusy(1) then
      repeat while the volume of sound 2 < 150
        set the volume of sound 2 to the volume of sound 2 + 10
        Wait(6)
      end repeat
    end if
    go(the frame)
  end repeat
  go("HEM")
end
