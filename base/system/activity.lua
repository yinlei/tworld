-------------------------------------------------------------------------------
-- activity.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local class = require "lib.middleclass"

local System = require(_PACKAGE.."/system")

local ActivitySystem = class("ActivitySystem", System)

function ActivitySystem:initialize(owner)
    System.initialize(self, owner)
end

-- TODO

return ActivitySystem
