on exitFrame
  global gOvn_Level, WaitForUserStart, gNIV_castV, gNIV_castH, decDate
  gNIV_castV = 59
  gNIV_castH = 79
  fl_visible_off(3, 10)
  fl_visible_off(26, 33)
  fl_visible_off(14, 22)
  fl_visible_off(37, 44)
  init_memory_lek()
  go(#next)
end
