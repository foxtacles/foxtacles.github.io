on exitFrame
  dp = the pathName
  if char length(dp) of dp = "\" then
    dp = char 1 to (length(dp) - 1) of dp
  end if
  if the machineType = 256 then
    the searchPaths = [dp & "\main"]
  else
    the searchPaths = [dp & ":main"]
  end if
end
