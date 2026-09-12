on choosePlayers
  repeat with i = 55 to 83
    set the locV of sprite i to the locV of sprite i + 2
    if the locV of sprite i > 500 then
      set the locV of sprite i to -20
      set the locH of sprite i to random(640)
    end if
    if (i mod 2) = 0 then
      set the locV of sprite i to the locV of sprite i + 1
    end if
  end repeat
end
