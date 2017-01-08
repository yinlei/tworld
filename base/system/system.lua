-------------------------------------------------------------------------------
-- system.lua
-------------------------------------------------------------------------------
local class = require "lib.middleclass"

local System = class("System")

function System:initialize(owner)
    self.owner = {}
    setmetatable(self.owner, {__mode = 'v'})
    self.owner.ref = owner
end

function System:owner()
    return self.owner.ref
end

function System:avatar()
    return self.owner.ref
end

return System
