local M = {}

local timers = {}

function M.frames(frames, callback)
  if frames == 0 then
    callback()
  else
    table.insert(timers, {frames = frames, callback = callback})
  end
end

function M.seconds(seconds, callback)
  table.insert(timers, {seconds = seconds, callback = callback})
end

function M.cancel_all()
  timers = {}
end

function M.update(dt)
  for k, timer in pairs(timers) do
    if timer.frames then
      timer.frames = timer.frames - 1
      if timer.frames <= 0 then
        timers[k] = nil
        timer.callback()
      end
    elseif timer.seconds then
      timer.seconds = timer.seconds - dt
      if timer.seconds <= 0 then
        timers[k] = nil
        timer.callback()
      end
    end
  end
end

return M
