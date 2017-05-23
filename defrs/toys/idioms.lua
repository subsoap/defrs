--- This file is not meant to be ran as a whole, it's a ref
-- instead copy and paste (or better type) into other files to run each
-- it's a cheatsheet refresher of examples
-- / common ideas / idioms / design patterns

--- create a key value store / map / associative array
-- get contents of a table
tool_data_table = {name = "Defold", use = "gamedev"}
print(tool_data_table.name)

--- set random seed to current local time
-- get local unix timestamp in seconds
math.randomseed(os.time())

--- get formatted time in YYYY-MM-DD
print(os.date("%F", os.time()))
print(os.date("%F", os.time({year = 2000, month = 8, day = 24})))

--- get a random number between a range
lower = 0
upper = 10
print(math.random(lower, upper))

--- calculate sum of a list of integers
numbers = {1,2,3,4,5}
sum = 0
for i,v in ipairs(numbers) do
   sum = sum + v
end
print(sum)

--- convert a number to a string
-- concatinate strings
-- get type of
number = 5
string = tostring(number)
print(string .. " is type " .. type(string))

--- currying - partial function application
-- can pass all arguments a function expects
-- or pass some arguments and get a function back waiting for the rest
-- common concept in functional programming languages (and general math)
-- non-curried function
function add_values(a,b)
  return a + b
end
print(add_values(1,2))
-- curried function
-- one argument is taken, returns a function which takes another
-- which returns the sum
function add_values_curried(a)
  return function(b)
    return a + b
  end
end
print(add_values_curried(1)(2))
add_1 = add_values_curried(1)
print(add_1) -- incomplete curry, could be reused over and over
print(add_1(add_1(add_1(3)))) -- incomplete curry applied multiple times
incomplete_curry = add_values_curried(5)
print(incomplete_curry) -- a function waiting for final argument
print(incomplete_curry(5)) -- the final argument applied

--- general purpose currying function
function curry(curried_function)
  return function (x)
    return function (y)
      return curried_function(x,y)
    end
  end
end
-- used for pow
pow_curry = curry(math.pow)
print(pow_curry(8)(2)) -- 8^2
pow2 = pow_curry(2)
print(pow2(2))
print(pow2(4))
print(pow2(6))
print(pow2(8))

--- another curried function example
-- non-curried version
function greet(greeting, name)
  print(greeting .. ", " .. name)
end
greet("Hej", "Defold")
-- curried version
function greet_curried(greeting)
  return function(name)
    print(greeting .. ", " .. name)
  end
end
greet_hej = greet_curried("Hej")
greet_hi = greet_curried("Hi")
print(greet_hej("Defold"))
print(greet_hi("Defold"))
print(greet_curried("Hola")("Defold"))
-- we have to go deeper
greet_curried_deep = function(word)
  return function(end_symbol)
    return function(spacing)
      return function(thing)
        print(word .. spacing .. thing .. end_symbol)
      end
    end
  end
end
greet_leet = greet_curried_deep("h3ll0")("!!!")(", ")
greet_leet("Defold") -- h3ll0, Defold!!!
greet_leet("Cat") -- h3ll0, Cat!!!
greet_leet("Fish") -- h3ll0, Fish!!!
-- create a library of partially applied functions out of building blocks
-- pass custom functions to higher order functions (functions which
-- get other functions as arguments)

--- recursive factorial to get product of all integers below it in value
-- tail recursive function
function recursive_factorial(number)
  local function recursive_factorial_(factorial, number)
    if number < 2 then return factorial end
    return recursive_factorial_(factorial*number, number-1)
  end
  return recursive_factorial_(1, number) -- this executes first
  -- to begin the tail recursive function
end
print(recursive_factorial(4)) -- 4! = 4*3*2 = 24

--- get time in milliseconds
-- multiply by 10k to get a whole number
require('socket')
print(socket.gettime() * 10000)

--- pause execution for some time
-- get time since the Lua app started
local start = os.clock() -- os.clock() begins at 0
while os.clock() - start < 5 do print(os.clock()*1000) end -- msecs
print(os.clock())

--- infinite loop
while true do
 print("It never ends! ")
 return 0 -- an escape! but uncomment to go forever!
end

--- sort by comparator - relational operators
-- join values of a table together with a delimiter between each
animals = {"zebra", "aalpaca", "cat", "dog", "alpaca","bat", "horse"}
function sort_animal_order_atoz(first,second)
    return second > first
end
print(table.concat(animals, ","))-- zebra,aalpaca,cat,dog,alpaca,bat,horse
table.sort(animals, sort_animal_order_atoz)
print(table.concat(animals, ","))-- aalpaca,alpaca,bat,cat,dog,horse,zebra

--- get version of Lua running (should be 5.1! for Defold)
print(tonumber(_VERSION:match("%d%.*%d*")))

--- check string prefix
my_string = "defold.com"
my_prefix = "def"
print(my_string:find(my_prefix) == 1)

--- check string suffix
my_string = "defold.com"
my_suffix = ".com"
print(my_string:sub(-string.len(my_suffix)) == my_suffix)

--- multiple return values
-- multiple assignment
function return_values()
  return 1,2,3,4,5
end
a,b,c,d,e = return_values()
print(a,b,c,d,e)

--- convert string to number
number = "5"
print(tonumber(number))

--- multi line string
multi_line_string = [[
Do
Good
Work!
]]
print(multi_line_string)

--- simple 2d vector point
vector2d_point = { x = 5, y = 12 }

--- truncate non-int number to integer
integer_number, fractional = math.modf(77.999)
print(integer_number, fractional)

--- set a default init value of 0 (or remain itself)
-- all begin as nil, operations don't like nil!
x = x or 0
print(x) -- 0
print(xx) -- nil
print(x + x) -- still 0, no error
print(x + xx) -- error

--- swap variables
a = 1
b = 0
a, b = b, a
print(a, b)

--- print a (simple) table
simple_table = {1,2,animal="cat",3,4,5}
for key, value in pairs(simple_table) do
  print(key, value)
end

--- exit a loop
timer = 0
while timer < 100 do
  timer = timer + 1
  print(timer)
  if timer == 25 then
    print("exit early!")
    break
  end
end

--- insert (push) and remove (pop) contents of a table
-- store removed values from tables into variables for other use
-- insert and remove default to inserting and removing from the last position
-- last position could also be selected with #table or second last #table -1
my_table = {}
table.insert(my_table, "there") -- {"there"}
table.insert(my_table, "hello") -- {"there", "hello"} <- hello inserted last
print(#my_table) -- 2
print(table.remove(my_table)) -- {"there"} <- last value removed
print(#my_table) -- 1
print(table.remove(my_table)) -- {}
print(#my_table) -- 0
print(table.remove(my_table)) -- prints nothing but new line
my_table = {"a", "b", "c", "d", "e"}
letter_c = table.remove(my_table, 3) -- {"a", "b", "d", "e"}
print(letter_c) -- c
-- insert at the start of a table - we use 1 to select first position
table.insert(my_table, 1, "z") -- {"z", "a", "b", "d", "e"}
-- remove from start of a table
print(table.remove(my_table, 1)) -- {"a", "b", "d", "e"}
-- beware of using these functions with large amounts of data

--- clojures
-- a clojure keeps memory of variables inside of it
function clojure_example()
  local memory = 0
  return function()
    memory = memory + 1
		return memory
  end
end

memory_keeper = clojure_example()
print(memory_keeper()) -- 1
print(memory_keeper()) -- 2
print(memory_keeper()) -- 3

--- coroutines
-- like a thread but cannot be ran in parallel, each takes turns
my_coroutine = coroutine.create(function()
  local i = 0
  while i < 5 do
		i = i + 1
    print(i)
    print(coroutine.status(my_coroutine))
    if i == 3 then
      coroutine.yield(my_coroutine)
    end
  end
end)

print(coroutine.status(my_coroutine)) -- suspended
coroutine.resume(my_coroutine)
print(coroutine.status(my_coroutine))

my_second_coroutine = coroutine.create(function()
	for i=0, 3, 1 do
		print("Second Coroutine: " .. i)
	end
end)

coroutine.resume(my_second_coroutine) -- execution waits until co finishes
coroutine.resume(my_coroutine) -- first co can now finish
print(coroutine.status(my_coroutine)) -- dead
print(coroutine.status(my_second_coroutine)) -- dead

--- ternary operator approximation
a = 0
print(a == 0 and 1 or 0) -- prints 1
-- because expressions return the last value it works as a ternary operator
a = 0
print(a == 0 and 1 and 2 or 0) -- would return 2 instead of 1 if a == 0
-- you should write if else statements most of the time for code clarity!


--- tables are references
-- this is why you need a good "deep copy" module in some situations to clone
a = {1,2,3}

function return_table(the_table)
 return the_table
end

b = return_table(a)

print(b[1])
print(a[1])
a[1] = 9
print(b[1]) -- prints 9!

--- shallow copy tables
-- only works for simple, flat table structures
-- search for deep copy lua modules for more exact cloning

original_table = {1, "fish", 2, "fish", "red fish", "blu fish", ["engine"] = "Defold", lang = "Lua"}

clone_table = {}
i,v = next(original_table, nil)
while i do
  clone_table[i] = v
  i,v = next(original_table,i)
end

clone_table[2] = "cat"
clone_table[4] = "dog"
clone_table[5] = "yellow bat"
clone_table[6] = "green frog"
clone_table.engine = "Gas"
clone_table.lang = "English"

print ("\noriginal")
for i,v in pairs(original_table) do
  print (i,v)
end

print ("\nclone")
for i,v in pairs(clone_table) do
  print (i,v)
end

--- deep copy a table (imperfect)
function clone (t)
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            target[k] = clone(v)
        else
            target[k] = v
        end
    end
    setmetatable(target, meta)
    return target
end

--- shallow copy a table (flat)
function copy (t)
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do target[k] = v end
    setmetatable(target, meta)
    return target
end

--- Euclidean algorithm / Greatest common divisor
function gcd(a, b)
    local x = a; local y = b
    repeat
        if x > y then
            x = math.fmod(x, y)
        else
            y = math.fmod(y, x)
        end
    until x == 0 or y == 0
    return x + y
end

---
function number_to_hex(number)
  return "0x" .. string.upper(string.format("%x", number))
end
print(number_to_hex(16))


---
function round_number(rounded_number, kept_decimal_places)
  if kept_decimal_places and kept_decimal_places > 0 then
    local multiplier = 10^kept_decimal_places
    return math.floor(rounded_number * multiplier + 0.5) / multiplier
  end
  return math.floor(rounded_number + 0.5)
end
print(round_number(5.2345, 2)) -- 5.23
print(round_number(5.2345, 0)) -- 5
print(round_number(-.5, 0)) -- problematic in some situations
