on RensaLjud KanalExclude
  repeat with Ki = 1 to 4
    if KanalExclude <> Ki then
      puppetSound(Ki, 0)
    end if
  end repeat
end
