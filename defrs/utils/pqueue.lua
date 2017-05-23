--- priority queue sorted by euclidian distance

local table = require "table"
local insert = table.insert
local remove = table.remove

local M = {}

function M.new(cmp, initial)
    local cmp = cmp or function(a,b) return a < b end

    local pq = setmetatable({}, {
        __index = {
            size = 0,
            push = function(self, v)
                insert(self, v)
                local next = #self
                local prev = (next-next%2)/2
                while next > 1 and cmp(self[next], self[prev]) do
                    self[next], self[prev] = self[prev], self[next]
                    next = prev
                    prev = (next-next%2)/2
                end
            end,
            pop = function(self)
                if #self < 2 then
                    return remove(self)
                end
                local root = 1
                local r = self[root]
                self[root] = remove(self)
                local size = #self
                if size > 1 then
                    local child = 2*root
                    while child <= size do
                        local aBool =   cmp(self[root],self[child]);
                        local bBool =   true;
                        local cBool =   true;
                        if child+1 <= size then
                            bBool =   cmp( self[root],self[child+1]);
                            cBool =   cmp(self[child], self[child+1]);
                        end
                        if aBool and bBool then
                            break;
                        elseif cBool then
                            self[root], self[child] = self[child], self[root]
                            root = child
                        else
                            self[root], self[child+1] = self[child+1], self[root]
                            root = child+1
                        end
                        child = 2*root
                    end
                end
                return r
            end,
            peek = function(self)
                return self[1]
            end,
        }
    })

    for _,el in ipairs(initial or {}) do
        pq:push(el)
    end

    return pq
end

-- pq = M.new(function(point1, point2)
--     return (point1[1]-point2[1])^2 + (point1[2]-point2[2])^2
-- end)
-- for i=1, 20 do
--     pq:push{math.random(100), math.random(100)}
-- end
-- print(unpack(pq:pop())) -- get the point closest to the origin

return M.new
