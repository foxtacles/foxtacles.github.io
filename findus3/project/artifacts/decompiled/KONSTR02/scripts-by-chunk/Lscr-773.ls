on BackupList SourceList
  DestList = []
  repeat with i = 1 to count(SourceList)
    setAt(DestList, i, getAt(SourceList, i))
  end repeat
  return DestList
end
