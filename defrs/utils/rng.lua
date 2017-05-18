local M = {}

-- Require this once to setup your math.rng so that it's random based on OS time
-- you do not need to call M.setup_rng() yourself and generally shouldn't

function M.setup_rng()
	math.randomseed(os.time() + math.random())
	math.random(); math.random(); math.random() -- clear bad rng	
end

M.setup_rng()

return M