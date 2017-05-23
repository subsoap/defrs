--- measure the speed of a section of Lua code
-- call mark1, mark2, and mark3 in order. The intended use case is to either
-- isolate a bottleneck - decided between the first or second interval measured
-- or to get an absolute measure of the average run time of the code
-- between mark1 and mark3.
-- public domain

local t_sum = 0
local t_num = 0
local t1, t2, t3
local do_time = true

local function mark1()
  if not do_time then return end
  t1 = os.clock()
end

local function mark2()
  if not do_time then return end
  t2 = os.clock()
end

local function mark3()
  if not do_time then return end
  t3 = os.clock()

  print('---')
  print(string.format('t1-t3 took %gs', t3 - t1))
  print(string.format('t1-t2 took %gs', t2 - t1))
  print(string.format('t2-t3 took %gs', t3 - t2))

  t_sum = t_sum + t3 - t1
  t_num = t_num + 1
  print(string.format('avg t1-t3 is now %gs', t_sum / t_num))
end
