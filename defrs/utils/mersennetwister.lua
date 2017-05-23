 -- Based on: 
 -- MT19937: 32-bit Mersenne Twister by Matsumoto and Nishimura, 1998
 -- http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/ARTICLES/mt.pdf
 -- https://en.wikipedia.org/wiki/Mersenne_Twister
 -- This work is licensed under the Creative Commons Attribution 4.0 International License. 
 -- To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
 -- Author: Mr Doomah - with slight modifications

local M = {}

 
local w, n, m, r = 32, 624, 397, 31
local a = 0x9908B0DF
local u = 11
local s, b = 7, 0x9D2C5680
local t, c = 15, 0xEFC60000
local l = 18
local f = 1812433253

 -- Assign functions
local bnot = bit.bnot
local bxor = bit.bxor
local band = bit.band
local bor = bit.bor
local rshift = bit.rshift
local lshift = bit.lshift
local function int32(int) -- 32 bits
	return band(int, 0xFFFFFFFF)
end

 -- Create an array to store the state of the generator
local MT = {}
local index = n+1
local lower_mask = lshift(1, r) -1
local upper_mask = int32(bnot(lower_mask))
 
 -- Initialize the generator from a seed
function M.seed_mt(seed)
	index = n
	if not seed then seed = os.time() end
	MT[0] = int32(seed)
	for i = 1, n-1 do
		MT[i] = int32(f * bxor(MT[i-1], rshift(MT[i-1], w-2) + i))
	end
end

 -- Extract a tempered value based on MT[index]
 -- calling M.twist() every n numbers
function M.extract_number()
	if index >= n then
		if index > n then 
			M.seed_mt()
		end
		M.twist()
	end
	
	local y = MT[index]
	y = bxor(y, rshift(y, u))
	y = bxor(y, band(lshift(y, s), b))
	y = bxor(y, band(lshift(y, t), c))
	y = bxor(y, rshift(y, l))
	
	index = index+1
	return int32(y)
end 

 -- Generate the next n values from the series x_i 
function M.twist()
	for i = 0, n-1 do
		local x = bor(band(MT[i], upper_mask), band(MT[(i+1) % n], lower_mask))
		local xA = rshift(x, 1)
		if x % 2 ~= 0 then
			xA = bxor(xA, a)
		end
		MT[i] = int32(bxor(MT[(i + m) % n], xA))
	end
	index = 0
end

 -- Function to call to get a random number
function M.random(p, q)
	if p then
		if q then
			return p + M.extract_number() % (q - p + 1)
		else
			return 1 + M.extract_number() % p
		end
	else
		return M.extract_number() / 0xFFFFFFFF
	end
end

return M