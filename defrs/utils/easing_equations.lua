-- Math based motion.

local M = {}

local pow, sin, cos, pi, sqrt, abs, asin  = math.pow, math.sin, math.cos, math.pi, math.sqrt, math.abs, math.asin

function M.linear(time_current, beginning_value, change, duration_total)
  return change * time_current / duration_total + beginning_value
end

-- time_current^2
function M.in_quadratic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total
  return change * pow(time_current, 2) + beginning_value
end

function M.out_quadratic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total
  return -change * time_current * (time_current - 2) + beginning_value
end

function M.in_out_quadratic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total * 2
  if time_current < 1 then
    return change / 2 * pow(time_current, 2) + beginning_value
  else
    return -change / 2 * ((time_current - 1) * (time_current - 3) - 1) + beginning_value
  end
end

function M.out_in_quadratic(time_current, beginning_value, change, duration_total)
  if time_current < duration_total / 2 then
    return M.out_quadratic (time_current * 2, beginning_value, change / 2, duration_total)
  else
    return M.in_quadratic((time_current * 2) - duration_total, beginning_value + change / 2, change / 2, duration_total)
  end
end

-- time_current^3
function M.in_cubic (time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total
  return change * pow(time_current, 3) + beginning_value
end

function M.out_cubic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total - 1
  return change * (pow(time_current, 3) + 1) + beginning_value
end

function M.in_out_cubic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total * 2
  if time_current < 1 then
    return change / 2 * time_current * time_current * time_current + beginning_value
  else
    time_current = time_current - 2
    return change / 2 * (time_current * time_current * time_current + 2) + beginning_value
  end
end

function M.out_in_cubic(time_current, beginning_value, change, duration_total)
  if time_current < duration_total / 2 then
    return M.out_cubic(time_current * 2, beginning_value, change / 2, duration_total)
  else
    return M.in_cubic((time_current * 2) - duration_total, beginning_value + change / 2, change / 2, duration_total)
  end
end

-- time_current^4
function M.in_quartic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total
  return change * pow(time_current, 4) + beginning_value
end

function M.out_quartic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total - 1
  return -change * (pow(time_current, 4) - 1) + beginning_value
end

function M.in_qut_quartic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total * 2
  if time_current < 1 then
    return change / 2 * pow(time_current, 4) + beginning_value
  else
    time_current = time_current - 2
    return -change / 2 * (pow(time_current, 4) - 2) + beginning_value
  end
end

function M.out_in_quartic(time_current, beginning_value, change, duration_total)
  if time_current < duration_total / 2 then
    return M.out_quartic(time_current * 2, beginning_value, change / 2, duration_total)
  else
    return M.in_quartic((time_current * 2) - duration_total, beginning_value + change / 2, change / 2, duration_total)
  end
end

-- time_current^5
function M.in_quintic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total
  return change * pow(time_current, 5) + beginning_value
end

function M.out_quintic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total - 1
  return change * (pow(time_current, 5) + 1) + beginning_value
end

function M.in_out_quintic(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total * 2
  if time_current < 1 then
    return change / 2 * pow(time_current, 5) + beginning_value
  else
    time_current = time_current - 2
    return change / 2 * (pow(time_current, 5) + 2) + beginning_value
  end
end

function M.out_in_quintic(time_current, beginning_value, change, duration_total)
  if time_current < duration_total / 2 then
    return M.out_quintic(time_current * 2, beginning_value, change / 2, duration_total)
  else
    return M.in_quintic((time_current * 2) - duration_total, beginning_value + change / 2, change / 2, duration_total)
  end
end

-- sin(time_current)
function M.in_sine(time_current, beginning_value, change, duration_total)
  return -change * cos(time_current / duration_total * (pi / 2)) + change + beginning_value
end

function M.out_sine(time_current, beginning_value, change, duration_total)
  return change * sin(time_current / duration_total * (pi / 2)) + beginning_value
end

function M.in_out_sine(time_current, beginning_value, change, duration_total)
  return -change / 2 * (cos(pi * time_current / duration_total) - 1) + beginning_value
end

function M.out_in_sine(time_current, beginning_value, change, duration_total)
  if time_current < duration_total / 2 then
    return M.out_sine(time_current * 2, beginning_value, change / 2, duration_total)
  else
    return M.in_sine((time_current * 2) -duration_total, beginning_value + change / 2, change / 2, duration_total)
  end
end

-- 2^time_current
function M.in_exponential(time_current, beginning_value, change, duration_total)
  if time_current == 0 then
    return beginning_value
  else
    return change * pow(2, 10 * (time_current / duration_total - 1)) + beginning_value - change * 0.001
  end
end

function M.out_exponential(time_current, beginning_value, change, duration_total)
  if time_current == duration_total then
    return beginning_value + change
  else
    return change * 1.001 * (-pow(2, -10 * time_current / duration_total) + 1) + beginning_value
  end
end

function M.in_out_exponential(time_current, beginning_value, change, duration_total)
  if time_current == 0 then return beginning_value end
  if time_current == duration_total then return beginning_value + change end
  time_current = time_current / duration_total * 2
  if time_current < 1 then
    return change / 2 * pow(2, 10 * (time_current - 1)) + beginning_value - change * 0.0005
  else
    time_current = time_current - 1
    return change / 2 * 1.0005 * (-pow(2, -10 * time_current) + 2) + beginning_value
  end
end

function M.out_in_exponential(time_current, beginning_value, change, duration_total)
  if time_current < duration_total / 2 then
    return M.out_exponential(time_current * 2, beginning_value, change / 2, duration_total)
  else
    return M.in_exponential((time_current * 2) - duration_total, beginning_value + change / 2, change / 2, duration_total)
  end
end

-- sqrt(1-time_current^2)
function M.in_circular(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total
  return(-change * (sqrt(1 - pow(time_current, 2)) - 1) + beginning_value)
end

function M.out_circular(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total - 1
  return(change * sqrt(1 - pow(time_current, 2)) + beginning_value)
end

function M.in_out_circular(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total * 2
  if time_current < 1 then
    return -change / 2 * (sqrt(1 - time_current * time_current) - 1) + beginning_value
  else
    time_current = time_current - 2
    return change / 2 * (sqrt(1 - time_current * time_current) + 1) + beginning_value
  end
end

function M.out_in_circular(time_current, beginning_value, change, duration_total)
  if time_current < duration_total / 2 then
    return M.out_circular(time_current * 2, beginning_value, change / 2, duration_total)
  else
    return M.in_circular((time_current * 2) - duration_total, beginning_value + change / 2, change / 2, duration_total)
  end
end

-- exponentially decaying sine wave
function M.in_elastic(time_current, beginning_value, change, duration_total, amplitude, period)
  if time_current == 0 then return beginning_value end

  time_current = time_current / duration_total

  if time_current == 1  then return beginning_value + change end

  if not period then period = duration_total * 0.3 end

  local overshoot

  if not amplitude or amplitude < abs(change) then
    amplitude = change
    overshoot = period / 4
  else
    overshoot = period / (2 * pi) * asin(change/amplitude)
  end

  time_current = time_current - 1

  return -(amplitude * pow(2, 10 * time_current) * sin((time_current * duration_total - overshoot) * (2 * pi) / period)) + beginning_value
end

function M.out_elastic(time_current, beginning_value, change, duration_total, amplitude, period)
  if time_current == 0 then return beginning_value end

  time_current = time_current / duration_total

  if time_current == 1 then return beginning_value + change end

  if not period then period = duration_total * 0.3 end

  local overshoot

  if not amplitude or amplitude < abs(change) then
    amplitude = change
    overshoot = period / 4
  else
    overshoot = period / (2 * pi) * asin(change/amplitude)
  end

  return amplitude * pow(2, -10 * time_current) * sin((time_current * duration_total - overshoot) * (2 * pi) / period) + change + beginning_value
end


function M.in_out_elastic(time_current, beginning_value, change, duration_total, amplitude, period)
  if time_current == 0 then return beginning_value end

  time_current = time_current / duration_total * 2

  if time_current == 2 then return beginning_value + change end

  if not period then period = duration_total * (0.3 * 1.5) end
  if not amplitude then amplitude = 0 end

  local overshoot

  if not amplitude or amplitude < abs(change) then
    amplitude = change
    overshoot = period / 4
  else
    overshoot = period / (2 * pi) * asin(change / amplitude)
  end

  if time_current < 1 then
    time_current = time_current - 1
    return -0.5 * (amplitude * pow(2, 10 * time_current) * sin((time_current * duration_total - overshoot) * (2 * pi) / period)) + beginning_value
  else
    time_current = time_current - 1
    return amplitude * pow(2, -10 * time_current) * sin((time_current * duration_total - overshoot) * (2 * pi) / period ) * 0.5 + change + beginning_value
  end
end

function M.out_in_elastic(time_current, beginning_value, change, duration_total, amplitude, period)
  if time_current < duration_total / 2 then
    return M.out_elastic(time_current * 2, beginning_value, change / 2, duration_total, amplitude, period)
  else
    return M.in_elastic((time_current * 2) - duration_total, beginning_value + change / 2, change / 2, duration_total, amplitude, period)
  end
end


-- overshooting cubic easing (overshoot+1)*time_current^3 - overshoot*time_current^2
function M.in_back(time_current, beginning_value, change, duration_total, overshoot)
  if not overshoot then overshoot = 1.70158 end
  time_current = time_current / duration_total
  return change * time_current * time_current * ((overshoot + 1) * time_current - overshoot) + beginning_value
end

-- back easing out: moving towards target overshooting it then reversing and coming back to target
function M.out_back(time_current, beginning_value, change, duration_total, overshoot)
  if not overshoot then overshoot = 1.70158 end
  time_current = time_current / duration_total - 1
  return change * (time_current * time_current * ((overshoot + 1) * time_current + overshoot) + 1) + beginning_value
end

function M.in_out_back(time_current, beginning_value, change, duration_total, overshoot)
  if not overshoot then overshoot = 1.70158 end
  overshoot = overshoot * 1.525
  time_current = time_current / duration_total * 2
  if time_current < 1 then
    return change / 2 * (time_current * time_current * ((overshoot + 1) * time_current - overshoot)) + beginning_value
  else
    time_current = time_current - 2
    return change / 2 * (time_current * time_current * ((overshoot + 1) * time_current + overshoot) + 2) + beginning_value
  end
end

function M.out_in_back(time_current, beginning_value, change, duration_total, overshoot)
  if time_current < duration_total / 2 then
    return M.out_back(time_current * 2, beginning_value, change / 2, duration_total, overshoot)
  else
    return M.in_back((time_current * 2) - duration_total, beginning_value + change / 2, change / 2, duration_total, overshoot)
  end
end

-- exponentially decaying parabolic bounce
function M.out_bounce(time_current, beginning_value, change, duration_total)
  time_current = time_current / duration_total
  if time_current < 1 / 2.75 then
    return change * (7.5625 * time_current * time_current) + beginning_value
  elseif time_current < 2 / 2.75 then
    time_current = time_current - (1.5 / 2.75)
    return change * (7.5625 * time_current * time_current + 0.75) + beginning_value
  elseif time_current < 2.5 / 2.75 then
    time_current = time_current - (2.25 / 2.75)
    return change * (7.5625 * time_current * time_current + 0.9375) + beginning_value
  else
    time_current = time_current - (2.625 / 2.75)
    return change * (7.5625 * time_current * time_current + 0.984375) + beginning_value
  end
end

function M.in_bounce(time_current, beginning_value, change, duration_total)
  return change - M.out_bounce(duration_total - time_current, 0, change, duration_total) + beginning_value
end

function M.in_out_bounce(time_current, beginning_value, change, duration_total)
  if time_current < duration_total / 2 then
    return M.in_bounce(time_current * 2, 0, change, duration_total) * 0.5 + beginning_value
  else
    return M.out_bounce(time_current * 2 - duration_total, 0, change, duration_total) * 0.5 + change * .5 + beginning_value
  end
end

function M.out_in_bounce(time_current, beginning_value, change, duration_total)
  if time_current < duration_total / 2 then
    return M.out_bounce(time_current * 2, beginning_value, change / 2, duration_total)
  else
    return M.in_bounce((time_current * 2) - duration_total, beginning_value + change / 2, change / 2, duration_total)
  end
end
  
return M
