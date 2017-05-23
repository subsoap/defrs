--- 2D vector library
-- Intended to work with any table that contains x,y component.
-- Be efficient, simple and fast, accept tables as parameters, avoid unnecessary validations.
-- Assumptions on this Doc:
-- -Every time "vector" refer to any table with {x,y} components. A 2D vector.
--@module vec2d.lua
--@author Denys Almaral (denysalmaral.com)
--@license MIT
--@usage vec = require('vec2d')
--@usage v={x=10,y=15}
-- M.add(v, M.makeFromAngle(math.pi/6))
-- M.normalize(v)
-- M.rotate(v, math.pi/4)

--- Module return a table with all functions
local M = {}

---Returns a new vector by copy
-- @param v Vector
-- @return a new vector cloned
function M.makeFrom(v)
  return {x=v.x, y=v.y}
end

---Sets x,y values to vDest vector
function M.set(vDest, x, y)
  vDest.x = x
  vDest.y = y
end

--- Copy vector v to vDest
function M.setFrom(vDest, v)
  vDest.x = v.x
  vDest.y = v.y
end

---Adds v to vDest, result in vDest
function M.add(vDest, v)
  vDest.x = vDest.x + v.x
  vDest.y = vDest.y + v.y
end

---Sums v1+v2, result in vDest
function M.sum(vDest, v1, v2)
  vDest.x = v1.x + v2.x
  vDest.y = v1.y + v2.y
end

--- Sum v1+v2, return a new vector with the sum
function M.makeSum(v1, v2)
  return {x = v1.x + v2.x,
          y = v1.y + v2.y }
end

--- Substract V from vDest, result in vDest
function M.sub(vDest, v)
  vDest.x = vDest.x - v.x
  vDest.y = vDest.y - v.y
end

--- Returns new vector = (v1-v2)
function M.makeSub(v1, v2)
  return { x = v1.x -v2.y,
           y = v1.y -v2.y
         }
end

--- Scale vDest multiplying by num number
function M.scale(vDest, num)
  vDest.x = vDest.x * num
  vDest.y = vDest.y * num
end

--- Returns a new vector from V*m; where V is vector and m is a number
function M.makeScale(v, num)
  return { x = v.x * num,
           y = v.y * num }
end

---Returns only Z float value from vector cross product v1 X v2
function M.crossProd(v1, v2)
  return (v1.x* v2.y- v1.y* v2.x)
end

---returns number vectors dot product v1 * v2
function M.dotProd(v1, v2)
  return (v1.x* v2.x+ v1.y* v2.y)
end

---Multiply vDist by v, result in vDist
function M.multiply(vDest, v)
  vDest.x = vDest.x * v.x
  vDest.y = vDest.y * v.y
end

---Returns new vector multiplied v1*v2
function M.makeMultiply(v1, v2)
  return {v1.x*v2.x, v1.y*v2.y}
end

---Returns vector length float
function M.length(v)
  return math.sqrt(v.x*v.x + v.y*v.y)
end

---Returns sqr( M.length(v) ) float
function M.sqLength(v)
  return (v.x*v.x + v.y*v.y)
end

---Normalizing vDest vector
function M.normalize(vDest)
  local tmp = 1 / M.length(vDest)
  vDest.x = vDest.x * tmp
  vDest.y = vDest.y * tmp
end

---Returns new normalized vector from V
function M.makeNormalized(v)
  local tmp = 1 / M.length(v)
  return {
            v.x * tmp,
            v.y * tmp
          }
end

---Rotate vDist vector, given float angle in radiants
function M.rotate(vDest, angle)
    vDest.x = vDest.x * math.cos(angle) - vDest.y * math.sin(angle);
    vDest.y = vDest.x * math.sin(angle) + vDest.y * math.cos(angle);
end

---Returns new vector from V rotated by float angle
function M.makeRotated(v, angle)
    return {
      x = v.x * math.cos(angle) - v.y * math.sin(angle),
      y = v.x * math.sin(angle) + v.y * math.cos(angle)
    }
end

---Returns a normalized vector with float angle in radians
function M.makeFromAngle( angle )
  return {
    x = math.cos(angle),
    y = math.sin(angle)
  }
end

return M
