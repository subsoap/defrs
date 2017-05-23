-- all_top_sorts.lua
-- public domain
--
-- Generate all permutations - aka topological sorts - of
-- the set [1, 2, ..., n] such that the permutation has
-- certain pairs in a given order. This can also be thought
-- of as listing all linear orders consistent with a given
-- partial order.
--
-- This code is based on chapter 3 of
-- Donald Knuth's book Literate Programming.
--

-- Print out all topological sorts of [1, 2, ..., n]
-- consistent with a given list of ordered pairs.
-- The ordered pairs are given as an array of 2-element
-- arrays, each of which is a pair that will remain
-- in the given order. For example:
-- all_top_sorts(5, {{1, 3}, {2, 4}, {3, 2}})
function all_top_sorts(n, ordered_pairs)
  local larger = {}
  local D = {min = 1, max = 0}  -- This is an empty deque.
  local count = {}
  for i = 1, n do count[i], larger[i] = 0, {} end
  for _, p in ipairs(ordered_pairs) do
    -- Add p to larger.
    local bigger = larger[p[1]]
    bigger[#bigger + 1] = p[2]
    larger[p[1]] = bigger

    -- Add p to count.
    count[p[2]] = count[p[2]] + 1
  end

  -- Add all maximal (nothing-smaller-than-them) elements to D.
  for i = 1, n do
    if count[i] == 0 then push_back(D, i) end
  end

  local k = 0
  sub_top_sorts(n, k, larger, count, D, '')
end

-- Functions for working with a deque.
-- A deque is a table with string keys min and max such that the
-- sequence is D[D.min] .. D[D.max]; making pushing and
-- popping from either side easy.

function push_back(D, item)
  D.max = D.max + 1
  D[D.max] = item
end

function pop_back(D)
  local val = D[D.max]
  D[D.max] = nil
  D.max = D.max - 1
  return val
end

function push_front(D, item)
  D.min = D.min - 1
  D[D.min] = item
end

-- sub_top_sorts is the recursive function used by
-- all_top_sorts to do most of the work.
--
-- These are the parameters:
--  * n = Defines the set of integers being considered, [1..n].
--  * k = The number of items already printed as a prefix of
--        the about-to-be-printed subset of all_top_sorts.
--  * larger = A table so that larger[i] = array of items that
--             will be > i. That is, i < j for each j in larger[i].
--  * count = A table so that count[i] is the number of not-yet-
--            printed items that will be smaller than i.
--  * D = A table containing not-yet-printed items which are not
--        larger than anything else not-yet-printed. They can be
--        printed at any time. D is a deque (see above).
--  * indent = A string of all spaces that's useful for indenting
--             subsequent suffixes for easy printing & reading.
function sub_top_sorts(n, k, larger, count, D, indent)
  if k == n then return end
  local base = D[D.max]
  repeat

    local q = pop_back(D)
    local saved_larger_q = larger[q]
    for _, j in ipairs(larger[q]) do
      count[j] = count[j] - 1
      if count[j] == 0 then push_back(D, j) end
    end
    larger[q] = {}
    if q ~= base then io.write(indent) end
    io.write(q .. ' ')
    if k == n - 1 then io.write('\n') end
    sub_top_sorts(n, k + 1, larger, count, D, indent .. '  ')
    larger[q] = saved_larger_q
    for _, j in ipairs(larger[q]) do
      count[j] = count[j] + 1
      if count[j] == 1 then pop_back(D) end
    end
    push_front(D, q)
  until D[D.max] == base
end

-- Try out an example.
all_top_sorts(5, {{1, 3}, {2, 1}, {2, 4}, {4, 3}, {4, 5}})
