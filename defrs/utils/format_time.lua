local M = {}

function M.seconds_to_string(seconds)

	if seconds < 60 * 60 then -- MM:SS
		return string.format("%02d:%02d", math.floor(seconds / 60), seconds % 60 )
	elseif seconds < 60 * 60 * 24 then -- HH:MM:SS
		return string.format("%02d:%02d:%02d", math.floor(seconds / 3600), math.floor(seconds / 60) % 60, seconds % 60)
	else -- DD:HH:MM:SS
		return string.format("%02d:%02d:%02d:%02d", math.floor(seconds / (3600 * 24)), math.floor(seconds / 3600) % 24, math.floor(seconds / 60) % 60, seconds % 60)
	end

end

return M