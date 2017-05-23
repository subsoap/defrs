--- Convert between RGB colors and hex triplet colors
-- hex value needs to be a string and should have a leading #
-- RGB value can be either a string or a table
-- #FFFFFF <-> 255,255,255

local M = {}

function M.hex_to_rgb(hex)
  hex = hex:gsub("#", "") -- remove the leading # symbol if there
  local rgb = {}
  rgb.r = tonumber("0x" .. hex:sub(1,2))
  rgb.g = tonumber("0x" .. hex:sub(3,4))
  rgb.b = tonumber("0x" .. hex:sub(5,6))
  return rgb
end

function M.rgb_to_hex(rgb)
  local hex = "#"
  if type(rgb) == "string" then
    for color in rgb:gmatch("%d+") do
      hex = hex .. ("%X"):format(tostring(color))
    end
  elseif type(rgb) == "table" then
    for _, color in pairs(rgb) do
      hex = hex .. ("%X"):format(tostring(color))
    end
  end
  return hex
end

print(M.rgb_to_hex({255,255,255}))
print(M.rgb_to_hex("255,255,255"))
--newrgb = M.hex_to_rgb("#FFFFFF")
--print(newrgb.r, newrgb.g, newrgb.b)

return M
