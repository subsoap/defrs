-- Module for efficiently building up a string.
-- More efficient than repeated '..', according to PiL?
-- It has probably been implemented many times, but I put this together
-- from scratch because I wasn't about to go searching for extant libs.
--
-- Author: J. 'KwirkyJ' Smith <kwirkyj.smith0@gmail.com>
-- Date: 2016
-- Version: 1.0.0-0
-- License: MIT License



local stringbuffer = {_VERSION = "1.0.0-0"}

local bufferobj = {}



---(StringBuffer):add(...)
-- Add strings to the end of the buffer; can be either: 
-- (1) one or more strings, or 
-- (2) a list with an optional delimiter key;
-- first non-string element in the sequence terminates addition;
-- if provided table has a suffix, then its suffix is add after each element
-- added from that list;
-- if the StringBuffer object has a suffix set that is not '', then
-- its suffix is appended at the end of all additions made by the call.
-- @param ... One or more {Strings} 
--            or a {Table} indexed (1..n) with optional ['suffix'].
stringbuffer.add = function(bufferobj, ...)
    local list, suffix, len
    list = {...}
    if type(list[1]) == 'table' then
        list = list[1]
    end
    suffix = list['suffix']
    len = #bufferobj[1]
    for i=1, #list do
        if type(list[i]) ~= 'string' then break end
        len = len+1
        bufferobj[1][len] = list[i]
        if suffix then
            len = len+1
            bufferobj[1][len] = suffix
        end
    end
    --if suffix then
    --    bufferobj[1][#bufferobj[1]] = nil
    --end
    if bufferobj[2] and bufferobj[2] ~= '' then
        bufferobj[1][#bufferobj[1]+1] = bufferobj[2]
    end
end

---(StringBuffer):getString()
-- Convert the buffer to a string literal.
-- @return {String}
stringbuffer.getString = function(bufferobj)
    return table.concat(bufferobj[1])
end

---(StringBuffer):setSuffix(s)
-- Set a string to be appended at end of each add() call.
-- @param s {String} (default '')
-- @error Raised iff provided suffix is not a string.
stringbuffer.setSuffix = function(bufferobj, s)
    s = s or ''
    assert(type(s) == 'string', 'suffix must be string but was '.. type(string))
    bufferobj[2] = s
end



---StringBuffer.new([suffix])
-- Get a new StringBuffer table/object.
-- @param suffix {String} Optional string to add at the end of each add() call.
-- @error Raised if suffix is not a string or nil.
-- @return {StringBuffer}
stringbuffer.new = function(suffix)
    suffix = suffix or ''
    assert(type(suffix) == 'string', 'suffix must be string but was '.. type(suffix))
    
    return {[1] = {},
            [2] = suffix,
            add       = stringbuffer.add,
            getString = stringbuffer.getString,
            setSuffix = stringbuffer.setSuffix,
           }
end



return stringbuffer
