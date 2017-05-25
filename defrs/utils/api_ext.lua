-- Simply require this file
-- require("defrs.utils.api_ext")

function sprite.play_animation(url, animation)
	msg.post(url, "play_animation", {id = hash(animation)})
end