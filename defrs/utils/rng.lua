local M = {}

-- Require this once to setup your math.rng so that it's random based on OS time
-- you do not need to call M.setup_rng() yourself and generally shouldn't

function M.setup_rng()
	math.randomseed(os.time() + math.random())
	math.random(); math.random(); math.random() -- clear bad rng	
end

function M.random(first, second)
	if first == nil then
		return math.random()
	elseif second == nil then
		return math.random(first)
	else
		return math.random(first, second)
	end
end

function M.randomseed(seed)
	math.randomseed(seed)
end

M.setup_rng()

return M