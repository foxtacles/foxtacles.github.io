property spriteNum, castNum, maskcast, masksprite, xPos, yPos, animcount, animpos, curranimlist, curranimnumber, animlists, fp_xpos, fp_ypos, fp_speed, fp_scale, fp_accel, fp_oldxpos, fp_oldypos, sinTab, cosTab, angle, turnangle, targetangle, frames
global gGameWindow

on new me, spritenum0, castnum0, masksprite0, maskcast0, xpos0, ypos0
  spriteNum = spritenum0
  castNum = castnum0
  masksprite = masksprite0
  maskcast = maskcast0
  xPos = xpos0
  yPos = ypos0
  frames = 24
  fp_scale = 1000
  fp_xpos = xPos * fp_scale
  fp_ypos = yPos * fp_scale
  fp_oldxpos = fp_xpos
  fp_oldypos = fp_ypos
  fp_speed = 0
  fp_accel = 0
  angle = 90
  turnangle = 0
  targetangle = 90
  sinTab = list()
  cosTab = list()
  repeat with i = 0 to 360 - 1
    r = 3.14149999999999974 * i / 180.0
    add(sinTab, integer(fp_scale * sin(r)))
    add(cosTab, integer(fp_scale * cos(r)))
  end repeat
  animlists = list(list(1, 1000, -1, 1))
  initanim(me)
  setanim(me, 1)
  puppetSprite(spriteNum, 1)
  set the loc of sprite spriteNum to point(xPos, yPos)
  puppetSprite(masksprite, 1)
  set the memberNum of sprite masksprite to maskcast
  set the loc of sprite masksprite to point(xPos, yPos)
  return me
end

on move me
  targetangle = targetangle + turnangle
  if targetangle > 359 then
    targetangle = targetangle - 360
  else
    if targetangle < 0 then
      targetangle = targetangle + 360
    end if
  end if
  deltaangle = targetangle - angle
  if deltaangle > 180 then
    deltaangle = deltaangle - 360
  else
    if deltaangle < -180 then
      deltaangle = 360 + deltaangle
    end if
  end if
  if deltaangle > 0 then
    angle = angle + min(5, deltaangle)
  else
    if deltaangle < 0 then
      angle = angle + max(-5, deltaangle)
    end if
  end if
  if angle > 359 then
    angle = angle - 360
  else
    if angle < 0 then
      angle = angle + 360
    end if
  end if
  fp_speed = fp_speed + fp_accel
  if fp_speed > (fp_scale * 7) then
    fp_speed = fp_scale * 7
  else
    if fp_speed < (-fp_scale * 7) then
      fp_speed = -fp_scale * 7
    end if
  end if
  fp_deaccel = 500
  oldspeed = fp_speed
  if fp_speed > 0 then
    fp_speed = fp_speed - fp_deaccel
  else
    if fp_speed < 0 then
      fp_speed = fp_speed + fp_deaccel
    end if
  end if
  if (oldspeed * fp_speed) < 0 then
    fp_speed = 0
  end if
  if fp_speed = 0 then
    angle = targetangle
  end if
  fp_dx = fp_speed * getAt(cosTab, angle + 1) / fp_scale
  fp_dy = -fp_speed * getAt(sinTab, angle + 1) / fp_scale
  fp_oldxpos = fp_xpos
  fp_oldypos = fp_ypos
  fp_xpos = fp_xpos + fp_dx
  fp_ypos = fp_ypos + fp_dy
  xPos = fp_xpos / fp_scale
  yPos = fp_ypos / fp_scale
  doanim(me)
  c = ((targetangle * frames) + (targetangle / 2)) / 360
  if c >= frames then
    c = c - frames
  end if
  set the memberNum of sprite spriteNum to castNum + c
  set the loc of sprite spriteNum to point(xPos, yPos)
  set the loc of sprite masksprite to point(xPos, yPos)
end

on bounce me
  fp_speed = 0
  angle = targetangle
  fp_xpos = fp_oldxpos
  fp_ypos = fp_oldypos
end

on acc me, force
  fp_accel = force
end

on setturnangle me, a
  turnangle = a
end

on initanim me
  animcount = 1000
  animpos = 1
  curranimnumber = 0
  curranimlist = list(1, 1000, -1, 1)
end

on setanim me, num
  if num <> curranimnumber then
    animcount = 0
    animpos = 1
    curranimnumber = num
    curranimlist = getAt(animlists, curranimnumber)
  end if
end

on doanim me
  if animcount <= 0 then
    c0 = getAt(curranimlist, animpos)
    if c0 = 0 then
      animpos = animpos - 2
      c = getAt(curranimlist, animpos)
    else
      if c0 < 0 then
        animpos = (2 * getAt(curranimlist, animpos + 1)) - 1
        c = getAt(curranimlist, animpos)
      else
        c = c0
      end if
    end if
    animcount = getAt(curranimlist, animpos + 1)
    animpos = animpos + 2
    set the memberNum of sprite spriteNum to castNum + c - 1
  end if
  animcount = animcount - 1
end
