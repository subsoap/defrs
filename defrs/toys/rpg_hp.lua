--- apply damage randomly
-- use something like Mersenne Twister for good random numbers!
health = health or 100 -- total health
attack = attack or {min = 0, max = 10} -- range of possible attack
attack_damage = attack_damage or 0 -- init
total_attacks = total_attacks or 0 -- counter
_ = math.random(attack.min, attack.max) -- dispose of bad RNG
-- comment out the above and see what happens!
-- math.randomseed(os.time()) -- only uncomment after testing above
while health >= 1 do
  print("Current HP: " .. health)
  attack_damage = math.random(attack.min, attack.max)
  health = health - attack_damage
  total_attacks = total_attacks + 1
  print("Attack #: " .. total_attacks)
  if health <= 0 then
    print("Dead!")
  end
end
