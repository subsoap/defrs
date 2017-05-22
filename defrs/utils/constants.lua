local superstrict = require "defrs/utils/superstrict"

local M = {}

-- Built-in system messages.
M.EXIT                 = hash("exit")
M.REBOOT               = hash("reboot")
M.SET_UPDATE_FREQUENCY = hash("set_update_frequency")
M.START_RECORD         = hash("start_record")
M.STOP_RECORD          = hash("stop_record")
M.TOGGLE_PROFILE       = hash("toggle_profile")

-- Built-in game object messages.
M.ACQUIRE_INPUT_FOCUS = hash("acquire_input_focus")
M.DISABLE             = hash("disable")
M.ENABLE              = hash("enable")
M.RELEASE_INPUT_FOCUS = hash("release_input_focus")
M.SET_PARENT          = hash("set_parent")

-- Built-in render messages.
M.CLEAR_COLOR    = hash("clear_color")
M.DRAW_LINE      = hash("draw_line")
M.DRAW_TEXT      = hash("draw_text")
M.WINDOW_RESIZED = hash("window_resized")

-- Built-in sprite messages.
M.ANIMATION_DONE = hash("animation_done")
M.PLAY_ANIMATION = hash("play_animation")

-- Built-in sound messages.
M.PLAY_SOUND = hash("play_sound")
M.SET_GAIN   = hash("set_gain")
M.STOP_SOUND = hash("stop_sound")

-- Built-in spine messages.
M.SPINE_ANIMATION_DONE = hash("spine_animation_done")
M.SPINE_EVENT          = hash("spine_event")

-- Built-in collision messages.
M.APPLY_FORCE            = hash("apply_force")
M.COLLISION_RESPONSE     = hash("collision_response")
M.CONTACT_POINT_RESPONSE = hash("contact_point_response")
M.RAY_CAST_RESPONSE      = hash("ray_cast_response")
M.TRIGGER_RESPONSE       = hash("trigger_response")

-- Built-in collection proxy messages.
M.ASYNC_LOAD     = hash("async_load")
M.DISABLE        = hash("disable")
M.ENABLE         = hash("enable")
M.FINAL          = hash("final")
M.INIT           = hash("init")
M.LOAD           = hash("load")
M.PROXY_LOADED   = hash("proxy_loaded")
M.PROXY_UNLOADED = hash("proxy_unloaded")
M.SET_TIME_STEP  = hash("set_time_step")
M.UNLOAD         = hash("unload")

-- Built-in camera messages.
M.ACQUIRE_CAMERA_FOCUS = hash("acquire_camera_focus")
M.RELEASE_CAMERA_FOCUS = hash("release_camera_focus")
M.SET_CAMERA           = hash("set_camera")

-- Custom messages.


-- IDs.


-- Input.
M.TOUCH              = hash("touch")


-- Config.


-- Misc.
M.LEFT_UNIT     = vmath.vector3(-1, 0, 0)
M.RIGHT_UNIT    = vmath.vector3(1, 0, 0)
M.SCREEN_WIDTH  = tonumber(sys.get_config("display.width"))
M.SCREEN_HEIGHT = tonumber(sys.get_config("display.height"))
M.SCREEN_CENTER = vmath.vector3(M.SCREEN_WIDTH / 2, M.SCREEN_HEIGHT / 2, 0)

-- Lock all the things.
local locked = {
  M,
  sys,
  go,
  gui,
  render,
  crash,
  sprite,
  sound,
  tilemap,
  spine,
  particlefx,
  physics,
  factory,
  collectionfactory,
  iac,
  msg,
  vmath,
  http,
  image,
  json,
  zlib,
  iap,
  push,
  facebook
}
for _, t in ipairs(locked) do
  superstrict.lock(t)
end

return M
