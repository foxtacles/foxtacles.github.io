global G_LillTomteSpNr, G_SiffrorCNr, G_PoangAntalSiffror

on InitPoangLillTomte SpNr, CastNR, TwoThreeDigit
  G_LillTomteSpNr = SpNr
  G_SiffrorCNr = CastNR
  G_PoangAntalSiffror = TwoThreeDigit
end

on ShowPoangLillTomte LillPoang
  s = string(integer(LillPoang))
  repeat while length(s) < 3
    s = "0" & s
  end repeat
  repeat with i = 1 to 3
    b = charToNum(char i of s) - 48
    sprite(G_LillTomteSpNr + i).memberNum = G_SiffrorCNr + 1 + b
  end repeat
end
