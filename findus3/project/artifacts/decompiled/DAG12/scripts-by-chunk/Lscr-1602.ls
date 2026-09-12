on layOutSurprise surprise
  set the loc of sprite 5 to point(-1000, -1000)
  case surprise of
    1:
      set the loc of sprite 36 to point(323, 256)
      set the memberNum of sprite 4 to 54
      set the memberNum of sprite 13 to 52
      UNIcreateUniObject(5, 6, 1, [point(320, 480)], 3, [], 1)
    2:
      set the loc of sprite 38 to point(325, 210)
      set the loc of sprite 4 to point(-1000, -1000)
      set the memberNum of sprite 13 to 52
      UNIcreateUniObject(5, 6, 1, [point(320, 480)], 3, [], 2)
    3:
      set the loc of sprite 37 to point(315, 250)
      set the loc of sprite 4 to point(-1000, -1000)
      set the loc of sprite 13 to point(-1000, -1000)
      UNIcreateUniObject(5, 6, 1, [point(320, 480)], 3, [], 3)
    4:
      set the memberNum of sprite 4 to 54
      set the memberNum of sprite 13 to 52
      set the loc of sprite 35 to point(330, 205)
      sprite(35).locZ = 12
      UNIcreateUniObject(5, 6, 1, [point(320, 480)], 3, [], 4)
    5:
      UNIcreateUniObject(13, 6, 1, [point(325, 200)], 1)
      UNIcreateUniObject(5, 6, 1, [point(320, 480)], 3, [], 5)
    6:
      set the memberNum of sprite 4 to 54
      set the memberNum of sprite 13 to 55
      sprite(30).locZ = 12
      UNIcreateUniObject(9, 6, 1, [point(308, 243), point(308, 142), point(914, 142)], 1, [10, 11, 12])
      UNIcreateUniObject(10, 6, 1, [point(439, 266), point(439, 165), point(1045, 165)], 1)
      UNIcreateUniObject(11, 6, 1, [point(104, 176), point(104, 75), point(710, 75)], 1)
      UNIcreateUniObject(5, 6, 1, [point(320, 480)], 3, [], 6)
      puppetSound(2, "NyFx06")
  end case
end
