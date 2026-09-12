global decDate

on checkDate
  currentMonth = (the systemDate).month
  case currentMonth of
    12:
      currentday = (the systemDate).day
      if currentday < 25 then
        decDate = currentday
      else
        decDate = 25
      end if
    9, 10, 11:
      decDate = 1
    otherwise:
      decDate = 25
  end case
end
