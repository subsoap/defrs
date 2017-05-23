--- level up while gaining XP
-- this for example is very similar to the way Overwatch does XP
-- minus xp gain, but that's explained below
player_level = 1
xp_needed = 2000
current_xp = 0
total_xp = 0
xp_gained = 0
level_xp_amounts = {
		2000, 3500, 5000, 6500, 7500, 8500, 9500, 10500, 11500, 12500,
		13500, 14500, 15000, 16000, 16500, 17000, 17500, 18000, 18500,
		19000, 20000}
  -- 1 to 10 -- 11 to 20 -- 21 to 22 -- all next levels = 20k too
	-- 22+ XP stays same to keep grind from getting out of hand
  -- you could use a formula to calculate XP required on the fly too
  -- instead of using a lookup table, which just makes it easy to tune
  -- some games such as Pokemon use different formulas for different Pokemon
  -- and different formulas for different level ranges
  -- http://bulbapedia.bulbagarden.net/wiki/Experience
  -- you should look up XP formulas for your favorites RPGS
  -- for example, Demon's Souls http://demonssouls.wikidot.com/stat-slvl
  -- also used in Dark Souls, Bloodborne, and Dark Souls 3 (Dark Souls 2 was b-team)
  -- xp_required = 0.02 * level^3 + 3.06 * level^2 + 105.6 * level - 895
  -- above formula is used for levels 12 and up, the rest are hand coded
  -- (test it out to see why)
xp_gain_range = {min = 250, max = 500}
  -- just a random range for testing
  -- Overwatch gives 250XP per completed round + 500XP for winning
  -- and an extra 3.4 XP per second while in a match
  -- and other bonus XP for getting medals in game
  -- 50 XP for bronze, 100 XP for silver, 150 XP for gold
  -- only gives you highest medal earned in a match not for each
  -- consecutive match bonus 200 XP
  -- first win of the day bonus 1500 XP -- good excuse to play every day
  -- joining game in progress and finishing it 400 XP
  -- playing with a group +20% bonus
  -- Overwatch levels loops back to level 1 once player reaches level 101
  -- with an extra star next to name -- getting early levels fast is fun!
  -- learn from other games and make good progrssion systems for your project!
while player_level < 100 do
	xp_gained = math.random(xp_gain_range.min, xp_gain_range.max)
	total_xp = total_xp + xp_gained
	current_xp = current_xp + xp_gained
	if current_xp >= xp_needed then
		current_xp = current_xp - xp_needed
		player_level = player_level + 1
		if player_level > 21 then
			xp_needed = 20000
		else
			xp_needed = level_xp_amounts[player_level]
		end
	end
	print("Current level: " .. player_level .. ", Current XP: " .. current_xp .. ", Total XP: " .. total_xp .. ", XP Needed: " .. xp_needed)
end
