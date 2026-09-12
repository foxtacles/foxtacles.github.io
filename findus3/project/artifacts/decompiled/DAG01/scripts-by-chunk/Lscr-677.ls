global gCPRects

on exitFrame
  sprite(52).visible = 0
  gCPRects = list()
  i = 11
  c = the memberNum of sprite i
  repeat while c > 0
    add(gCPRects, the rect of sprite i)
    i = i + 1
    c = the memberNum of sprite i
  end repeat
  sprite(40).visible = 0
  sprite(41).visible = 0
  put EMPTY into field "tid_field"
end
