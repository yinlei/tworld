-------------------------------------------------------------------------------
-- action.lua
-------------------------------------------------------------------------------
local ERROR_MSG = tengine.ERROR_MSG
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local p = tengine.p

local class = require "lib.middleclass"
local weakref = tengine.helper.weakref

local SkillAction = class("SkillAction", weakref)

function SkillAction:initialize(owner, system)
    weakref.initialize(self, {owner = owner, system = system})

    self.action_timers = {}

end

--- 清空
function SkillAction:clear()
    local owner = self:owner()
    for k, v in pairs(self.action_timers) do
        owner:del_local_timer(k)
    end

    self.action_timers = {}
end

return SkillAction
