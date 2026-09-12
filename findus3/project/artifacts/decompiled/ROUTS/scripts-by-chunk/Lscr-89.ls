on kolladatum
  global KalenderDag
  DecSt = ["December", "Desember", "joulukuu", "dezemb", "dicemb", "diciemb", "dcemb"]
  NovSt = ["Novemb", "noviemb", "marraskuu"]
  OktSt = ["Oktober", "October", "lokakuu", "Oct", "Okt"]
  Datum = the long date
  DecJa = 0
  NovJa = 0
  OktJa = 0
  repeat with i = 1 to count(DecSt)
    if Datum contains DecSt[i] then
      DecJa = 1
    end if
  end repeat
  repeat with i = 1 to count(NovSt)
    if Datum contains NovSt[i] then
      NovJa = 1
    end if
  end repeat
  repeat with i = 1 to count(OktSt)
    if Datum contains OktSt[i] then
      OktJa = 1
    end if
  end repeat
  if DecJa or NovJa or OktJa then
    if DecJa then
      ggr = the number of words in Datum
      repeat with i = 1 to ggr
        Dagtest = word i of Datum
        if char 3 of Dagtest = "." then
          Dagtest = char 1 to 2 of Dagtest
        end if
        if char 2 of Dagtest = "." then
          Dagtest = char 1 of Dagtest
        end if
        if (integer(Dagtest) > 0) and (integer(Dagtest) < 31) then
          Dagen = integer(Dagtest)
        end if
      end repeat
      if Dagen < 13 then
        Dagen = 0
      end if
      if Dagen > 24 then
        Dagen = 999
      end if
    else
      Dagen = 0
    end if
  else
    Dagen = 999
  end if
  KalenderDag = Dagen
end
