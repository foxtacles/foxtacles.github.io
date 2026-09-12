on exitFrame
  if the mouseDown then
    repeat while the mouseDown
      nothing()
    end repeat
    quit()
  end if
  go(the frame)
end
