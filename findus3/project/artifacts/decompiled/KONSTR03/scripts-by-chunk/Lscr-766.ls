on OnOff
  global OnOff, ObjektAktiv, ObjektAktivProfil, AntalObjekt, UrsprObjektAktiv, PettSonFramme
  if PettSonFramme then
    TaFramBortPettson(3)
  end if
  if OnOff = 0 then
    OnOff = 1
    set the castNum of sprite 27 to 161
    updateStage()
    repeat while the mouseDown = 1
    end repeat
    UrsprObjektAktiv = BackupList(ObjektAktiv)
    PlaceraUtObjekt()
    HUVUDLOOP()
    OnOff = 0
    set the castNum of sprite 27 to 160
    repeat while the mouseDown = 1
    end repeat
    puppetSound(0)
    ObjektAktiv = BackupList(UrsprObjektAktiv)
    PlaceraUtObjekt()
  end if
end
