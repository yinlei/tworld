-------------------------------------------------------------------------------
-- add.lua
-------------------------------------------------------------------------------
local world = require "world"
local service = require "service"

local  _M = {}

function _M.command(a, b)
    return a+b
end

return _M
