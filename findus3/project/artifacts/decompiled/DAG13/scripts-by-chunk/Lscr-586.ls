on exitFrame
  puppetSound(1, "sark" & random(3))
  tupp = 45
  puppetSprite(tupp, 1)
  set the visible of sprite tupp to 1
  repeat while soundBusy(1)
    set the memberNum of sprite tupp to member("hona" & random(3)).memberNum
    updateStage()
    tid = the ticks
    repeat while the ticks < (tid + 8)
      if the mouseDown then
        puppetSound(0)
        set the visible of sprite tupp to 0
        puppetSprite(tupp, 0)
        go("hem")
        exit repeat
      end if
    end repeat
  end repeat
  puppetSound(1, "rim.aif")
  puppetSprite(tupp, 0)
end
