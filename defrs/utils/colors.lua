-- You can require this module and use it to set colors based on names
-- instead of needing to look up their RGB normalized decimal values
-- it has some common color names... add more and do a pull request!

-- local colors = require("defrs.utils.colors")
-- sprite.set_constant("#sprite", "tint", colors.red)

-- A random color function is included
-- print(colors.get_random_color())

-- You can convert a # color to rgba normalized too
-- pprint(colors.hex2rgba("#FFFFFF"))

-- todo: add all "web browser colors" with their standard names


local M = {}

M.black = vmath.vector4(0.0, 0.0, 0.0, 1.0)
M.red = vmath.vector4(1.0, 0.0, 0.0, 1.0)
M.yellow = vmath.vector4(1.0, 1.0, 0.0, 1.0)
M.orange = vmath.vector4(1.0, 0.5, 0.0, 1.0)
M.green = vmath.vector4(0.0, 1.0, 0.0, 1.0)
M.blue = vmath.vector4(0.0, 0.0, 1.0, 1.0)
M.white = vmath.vector4(1.0, 1.0, 1.0, 1.0)
M.magenta = vmath.vector4(1.0, 0.0, 1.0, 1.0)
M.cyan = vmath.vector4(0.0, 1.0, 1.0, 1.0)

M.redorange = vmath.vector4(0.921, 0.235, 0.0, 1.0)


M.grey10 = vmath.vector4(0.1, 0.1, 0.1, 1.0)
M.grey20 = vmath.vector4(0.2, 0.2, 0.2, 1.0)
M.grey30 = vmath.vector4(0.3, 0.3, 0.3, 1.0)
M.grey40 = vmath.vector4(0.4, 0.4, 0.4, 1.0)
M.grey50 = vmath.vector4(0.5, 0.5, 0.5, 1.0)
M.grey60 = vmath.vector4(0.6, 0.6, 0.6, 1.0)
M.grey70 = vmath.vector4(0.7, 0.7, 0.7, 1.0)
M.grey80 = vmath.vector4(0.8, 0.8, 0.8, 1.0)
M.grey90 = vmath.vector4(0.9, 0.9, 0.9, 1.0)

function M.get_random_color()
	return vmath.vector4(math.random(1,255)/255, math.random(1,255)/255, math.random(1,255)/255, 1.0)
end

function M.hex2rgba(hex) -- normalized
    hex = hex:gsub("#","")
    if(string.len(hex) == 3) then
        return vmath.vector4(tonumber("0x"..hex:sub(1,1)) * 17, tonumber("0x"..hex:sub(2,2)) * 17, tonumber("0x"..hex:sub(3,3)) * 17, 1.0)
    elseif(string.len(hex) == 6) then
        return vmath.vector4(tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)), 1.0)
    end
end


return M