on omstart
  global klar, ove, aktiv, LinCast, LinusFirstTime, LinusR
  klar = 0
  aktiv = 0
  unloadMember()
  cursor(4)
  set the loc of sprite 12 to point(0, 0)
  set the loc of sprite 13 to point(122, 312)
  set the loc of sprite 14 to point(526, 199)
  set the loc of sprite 15 to point(69, 249)
  set the loc of sprite 16 to point(556, 328)
  set the loc of sprite 17 to point(503, 266)
  set the loc of sprite 18 to point(119, 159)
  set the loc of sprite 19 to point(85, 82)
  set the loc of sprite 20 to point(577, 166)
  set the loc of sprite 21 to point(510, 79)
  updateStage()
  if LinusFirstTime = 1 then
    puppetSound(1, 201)
    LinusR = -1
    LinusFirstTime = 0
  else
    OldLinCast = LinCast
    SlumpOk = 0
    repeat while SlumpOk = 0
      LinusR = random(5) - 1
      LinCast = 120 + (LinusR * 10)
      if LinCast <> OldLinCast then
        SlumpOk = 1
      end if
    end repeat
    puppetSound(1, 201 + LinusR + 1)
  end if
  repeat while soundBusy(1)
    one = 0
    two = 0
    three = 0
    four = 0
    five = 0
    six = 0
    seven = 0
    eight = 0
    nine = 0
    repeat with chan = 13 to 21
      puppetSprite(chan, 1)
      Kanal = chan
      set the moveableSprite of sprite chan to 1
      repeat while Kanal <> 0
        pusselSlump = random(9)
        if (pusselSlump = 1) and (one = 0) then
          set the memberNum of sprite chan to LinCast + pusselSlump - 1
          one = 1
          Kanal = 0
        else
          if (pusselSlump = 2) and (two = 0) then
            set the memberNum of sprite chan to LinCast + pusselSlump - 1
            two = 1
            Kanal = 0
          else
            if (pusselSlump = 3) and (three = 0) then
              set the memberNum of sprite chan to LinCast + pusselSlump - 1
              three = 1
              Kanal = 0
            else
              if (pusselSlump = 4) and (four = 0) then
                set the memberNum of sprite chan to LinCast + pusselSlump - 1
                four = 1
                Kanal = 0
              else
                if (pusselSlump = 5) and (five = 0) then
                  set the memberNum of sprite chan to LinCast + pusselSlump - 1
                  five = 1
                  Kanal = 0
                else
                  if (pusselSlump = 6) and (six = 0) then
                    set the memberNum of sprite chan to LinCast + pusselSlump - 1
                    six = 1
                    Kanal = 0
                  else
                    if (pusselSlump = 7) and (seven = 0) then
                      set the memberNum of sprite chan to LinCast + pusselSlump - 1
                      seven = 1
                      Kanal = 0
                    else
                      if (pusselSlump = 8) and (eight = 0) then
                        set the memberNum of sprite chan to LinCast + pusselSlump - 1
                        eight = 1
                        Kanal = 0
                      else
                        if (pusselSlump = 9) and (nine = 0) then
                          set the memberNum of sprite chan to LinCast + pusselSlump - 1
                          nine = 1
                          Kanal = 0
                        end if
                      end if
                    end if
                  end if
                end if
              end if
            end if
          end if
        end if
        updateStage()
      end repeat
    end repeat
  end repeat
  set the loc of sprite 12 to point(0, 0)
  set the loc of sprite 13 to point(122, 312)
  set the loc of sprite 14 to point(526, 199)
  set the loc of sprite 15 to point(69, 249)
  set the loc of sprite 16 to point(556, 328)
  set the loc of sprite 17 to point(503, 266)
  set the loc of sprite 18 to point(119, 159)
  set the loc of sprite 19 to point(85, 82)
  set the loc of sprite 20 to point(577, 166)
  set the loc of sprite 21 to point(510, 79)
  updateStage()
  ove = 1
  cursor(0)
  go("bygg")
end
