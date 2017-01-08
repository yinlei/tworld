-------------------------------------------------------------------------------
-- check.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local LOG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG

local p = tengine.p

--------------------------------------------------------------------------------
local SkillAction = require (_PACKAGE.."/action")

--- 技能动作检测
SkillAction.static.ACTION_CHECK_NEED_EXECUTE = 1
SkillAction.static.ACTION_CHECK_CASTER_DEATH = 2
SkillAction.static.ACTION_CHECK_TARGET_DEATH = 3
SkillAction.static.ACTION_CHECK_TARGET_IN_AOI = 4
SkillAction.static.ACTION_CHECK_CAN_ATTACK = 5
SkillAction.static.ACTION_CHECK_IN_AOI = 6


local function check_need_execute(owner, action_data)
    if action_data.is_need_execute then
        return 0
    end

    return 1
end


local function check_caster_death(owner, ...)
    if owner:is_death() then
        return 1
    end

    return 0
end

local function check_in_aoi(owner, target)

end

local function check_target_death(owner, ...)
end

local function check_attackable(owner, ...)
end

local check_actions = {
}

--- 动作检测
function SkillAction:check(mode, ...)
    local owner = self:owner()

    local action = check_actions[mode]
    if not action then
        ERROR("SkillAction check cant find action %d !!!", mode)
        return
    end

    return action(owner, ...)
end
