on hanteraavsnitt
  global ljudavsnitt, bildavsnitt, AktBildAvsnitt, nextbild, AktLjudAvsnitt, startade
  slut = KollaAvsnittSlut(0)
  if nextbild <= count(AktBildAvsnitt) then
    if tid() > AktBildAvsnitt[nextbild][3] then
      slut = 0
      show(AktBildAvsnitt[nextbild])
      nextbild = nextbild + 1
    end if
  end if
end
