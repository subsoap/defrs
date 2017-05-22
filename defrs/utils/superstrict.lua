-- Protect error function from modification.
local _error = error

local M = {}

local function lock_newindex(t, n)
  _error("attempting to write value to '" .. n .. "' in locked table [" .. tostring(t) .. "]", 2)
end

local function lock_index(t, n)
  _error("attempting to read undefined value '" .. n .. "' in locked table [" .. tostring(t) .. "]", 2)
end

function M.lock(t)
  assert(t, "missing table to lock")
  local mt = getmetatable(t) or {}
  mt.__newindex = lock_newindex
  mt.__index = lock_index
  setmetatable(t, mt)
end

function M.unlock(t)
  assert(t, "missing table to unlock")
  local mt = getmetatable(t) or {}
  mt.__newindex = rawset
  mt.__index = rawget
  setmetatable(t, mt)
end

return M