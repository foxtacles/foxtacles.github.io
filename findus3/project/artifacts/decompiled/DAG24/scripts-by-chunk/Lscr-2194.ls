on clicked Snr
  global startsprites
  spnum = Snr
  if (spnum <> 0) and (spnum > startsprites[1]) then
    sprite(spnum).locZ = 500
  end if
end
