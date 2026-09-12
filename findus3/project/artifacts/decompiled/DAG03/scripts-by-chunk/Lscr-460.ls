global click, lastClick, grundlistan, slumplistan, score, lastscore, allaklarade, varde, antalkvar

on Wait hurmycket
  nu = the ticks
  repeat while (the ticks - nu) < hurmycket
  end repeat
end

on borjaom
  set the visible of sprite 44 to 1
  set the visible of sprite 45 to 1
  set the visible of sprite 46 to 1
  antalkvar = 12
  set the castNum of sprite 45 to 70 + antalkvar
  grundlistan = ["DAG03_E_FNISS.AIF", "DAG03_E_HIN003E.AIF", "DAG03_E_KUCELIKU.AIF", "DAG03_E_OLJ002D.AIF", "DAG03_E_OLJ002D.AIF", "DAG03_E_PRUTT.AIF", "DAG03_E_TJUTER.AIF", "DAG03_E_URK.AIF", "DAG03_E_FNISS.AIF", "DAG03_E_PANGPIP.AIF", "DAG03_E_KUL005G.AIF", "DAG03_E_KUL005G.AIF", "DAG03_E_HIN003E.AIF", "DAG03_E_HOU-HO.AIF", "DAG03_E_HOU-HO.AIF", "DAG03_E_KUCELIKU.AIF", "DAG03_E_URK.AIF", "DAG03_E_TRUMPET2.AIF", "DAG03_E_TRUMPET2.AIF", "DAG03_E_TJUTER.AIF", "DAG03_E_SKRATT.AIF", "DAG03_E_SKRATT.AIF", "DAG03_E_PRUTT.AIF", "DAG03_E_PANGPIP.AIF"]
  slumplistan = []
  repeat with i = 1 to 24
    tal = random(25 - i)
    varde = getAt(grundlistan, tal)
    addAt(slumplistan, i, varde)
    deleteAt(grundlistan, tal)
  end repeat
  put slumplistan
  click = 0
  lastClick = 0
  score = 0
  lastscore = 0
  allaklarade = 1
end
