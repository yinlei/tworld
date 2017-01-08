--------------------------------------------------------------------------------
-- id.lua
--------------------------------------------------------------------------------
local actor = tengine.actor
local lshift = tengine.bit.lshift

local _M = {}

local id = lshift(actor.self(), 24)

function _M.get()
    id = id + 1
    return id
end

return _M
