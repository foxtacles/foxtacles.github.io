on exitFrame
  global hona
  puppetSound(1, "sark" & random(3))
  tupp = 45
  puppetSprite(tupp, 1)
  set the visible of sprite tupp to 1
  repeat while soundBusy(1)
    set the memberNum of sprite tupp to member("hona" & random(3)).memberNum
    updateStage()
    tid = the ticks
    repeat while the ticks < (tid + 8)
      rollKnapp()
      if the mouseDown then
        set the visible of sprite 52 to 0
        puppetSound(0)
        set the visible of sprite tupp to 0
        puppetSprite(tupp, 0)
        exit repeat
      end if
    end repeat
    rollKnapp()
  end repeat
  hona = 1
  set the visible of sprite 52 to 0
  puppetSprite(tupp, 0)
  unloadMember(member(131), 133)
  unloadMember(member(43))
  go("meny")
end
