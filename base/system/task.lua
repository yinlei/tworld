-------------------------------------------------------------------------------
-- task.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local class = require "lib.middleclass"

local System = require(_PACKAGE.."/system")

local TaskSystem = class("TaskSystem", System)

function TaskSystem:initialize(owner)
    System.initialize(self, owner)
end

return TaskSystem
