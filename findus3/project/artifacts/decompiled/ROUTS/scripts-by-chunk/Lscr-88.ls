global MasterVolym

on FixaVolym Avsnitt, Typ
  if Typ = 1 then
    MasterVolym = MasterVolym + 25
  end if
  if Typ = -1 then
    MasterVolym = MasterVolym - 25
  end if
  if MasterVolym > 255 then
    MasterVolym = 255
  end if
  if MasterVolym < 40 then
    MasterVolym = 40
  end if
  MusikLevel = 120
  NyLevel = MusikLevel * (MasterVolym / 255.0)
  set the volume of sound 1 to MasterVolym
  set the volume of sound 2 to MasterVolym
  set the volume of sound 3 to MasterVolym
  if Avsnitt = 1 then
    set the volume of sound 4 to NyLevel
  else
    set the volume of sound 4 to MasterVolym
  end if
end
