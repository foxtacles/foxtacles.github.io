on initber1
  global ljudavsnitt, bildavsnitt, AktLjudAvsnitt, startade, nextbild, lastber, positions, showed, AktBildAvsnitt, blendTimer, BlendSprite
  ljudavsnitt = ["Ber01", "Ber02ny", "Ber02b", "Ber03ny", "Ber04a", "Ber04b", "Ber05a", "ber05b", "ber05c"]
  bildavsnitt = []
  add(bildavsnitt, [[3, point(320, 240), 0, 0], [50, point(495, 339), 100, 1], [49, point(182, 114), 1070, 1], [52, point(438, 109), 1320, 1], [51, point(225, 289), 1800, 1]])
  add(bildavsnitt, [[5, point(320, 252), 10, 1], [54, point(485, 144), 1409, 1]])
  add(bildavsnitt, [[7, point(338, 260), 10, 1], [56, point(174, 116), 300, 1], [57, point(489, 120), 2360, 1]])
  add(bildavsnitt, [[9, point(371, 296), 10, 1], [59, point(190, 81), 730, 1], [61, point(455, 126), 1050, 1], [60, point(130, 275), 1300, 1]])
  add(bildavsnitt, [[11, point(320, 240), 10, 1], [63, point(449, 122), 988, 1], [64, point(107, 224), 3000, 1]])
  add(bildavsnitt, [[13, point(320, 301), 10, 1], [66, point(320, 149), 180, 1], [67, point(490, 105), 400, 1]])
  add(bildavsnitt, [[15, point(320, 237), 10, 1], [69, point(155, 356), 360, 1], [70, point(461, 142), 690, 1]])
  add(bildavsnitt, [[17, point(320, 241), 10, 1]])
  add(bildavsnitt, [[17, point(320, 235), 0, 0]])
  AktLjudAvsnitt = 0
  nextbild = 1
  lastber = 1
  showed = []
  AktBildAvsnitt = []
  startTimer()
  blendTimer = the timer + 10
  startade = the timer
  BlendSprite = 0
end
