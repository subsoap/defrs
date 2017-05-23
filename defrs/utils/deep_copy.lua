--- Makes a proper copy of a table
-- supports meta tables and recursive structures
-- why: normally variables do not hold table values but table references
-- may require modification for your needs, see refs
-- http://www.lua.org/pil/2.5.html
-- http://lua-users.org/wiki/CopyTable
-- http://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-value

local M = {}

function M.deep_copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy3(k, s)] = copy3(v, s) end
  return res
end

return M
