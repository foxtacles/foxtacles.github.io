on changePicture startCastNumber, stopCastNumber, direction, spriteNumber, counter, counterChangeValue
  counter = counter + 1
  if counter = counterChangeValue then
    counter = 1
    set the memberNum of sprite spriteNumber to the memberNum of sprite spriteNumber + direction
    if the memberNum of sprite spriteNumber > stopCastNumber then
      set the memberNum of sprite spriteNumber to startCastNumber
    else
      if the memberNum of sprite spriteNumber < startCastNumber then
        set the memberNum of sprite spriteNumber to stopCastNumber
      end if
    end if
  end if
  return counter
end
