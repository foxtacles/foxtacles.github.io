on mouseUp
  global ObjektAktiv
  put "hej"
  if getAt(ObjektAktiv, 1) = 0 then
    puppetSound(cast(211))
    updateStage()
  else
    if getAt(ObjektAktiv, 5) = 0 then
      puppetSound(cast(206))
      updateStage()
    else
      if getAt(ObjektAktiv, 7) = 0 then
        puppetSound(cast(209))
      else
        if getAt(ObjektAktiv, 6) = 0 then
          puppetSound(cast(207))
        else
          if getAt(ObjektAktiv, 9) = 0 then
            puppetSound(cast(210))
          else
            if getAt(ObjektAktiv, 12) = 0 then
              puppetSound(cast(208))
            else
              puppetSound(cast(211))
            end if
          end if
        end if
      end if
    end if
  end if
end
