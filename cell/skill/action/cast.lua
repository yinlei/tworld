-------------------------------------------------------------------------------
-- cast.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local LOG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG

local p = tengine.p

local SkillAction = require (_PACKAGE.."/action")


---
function SkillAction:cast(skill_data, index, id, start_tick, targets)
    local owner = self:owner()

    local action_data = self:get_data(id)

    if not action_data then
        ERROR("SkillAction cast cant find action_data %d !!!", id)
        return
    end

    local ret = self:check(SkillAction.ACTION_CHECK_NEED_EXECUT, action_data)

    if ret ~= 0 then
        return
    end


    local timer_id = self:add_local_timer()
end
