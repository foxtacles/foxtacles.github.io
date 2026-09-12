on unclicked Snr
  global tomtearea, startsprites, TomteSprites, huvud, musch, kropp, skor, Ljud
  spnum = Snr
  if (spnum <> 0) and (spnum > startsprites[1]) then
    sprite(spnum).locZ = spnum
    if inside(sprite(spnum).loc, tomtearea) then
      sprite(spnum).loc = getTomtePos(spnum)
      checktomte(spnum)
    else
      sprite(spnum).loc = getStartPos(spnum)
      repeat with i = 1 to 4
        if TomteSprites[i] = spnum then
          TomteSprites[i] = 0
        end if
      end repeat
    end if
  end if
end
