local M = {}

-- Improve seeding on OSX and FreeBSD by throwing away the high part of time,
-- then reversing the digits so the least significant part makes the biggest
-- change.
math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))

function M.boolean()
  return math.random(0, 1) == 1
end

function M.angle(range)
  return (math.random() * range * 2) - range
end

function M.direction(direction, range)
  local angle = M.angle(range)
  return vmath.rotate(vmath.quat_rotation_z(angle), direction)
end

return M
