-------------------------------------------------------------------------------
-- 使用技能
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

--------------------------------------------------------------------------------
local SkillSystem = require (_PACKAGE.."/system")


--- 更新使用技能时间
function SkillSystem:update_tick(skill_data, tick)
    local last_skill = self.last_skill

    if last_skill.id == skill_data then
        last_skill.count = last_skill.count + 1
    else
        last_skill.id = skill_data.id
        last_skill.count = 1
    end

    self.bag:update_cast_tick(skill_data, tick)
    last_skill.tick = tick
end

--- 使用技能
function SkillSystem:use(id, targets, tick)
    p("SkillSystem use", id, targets, tick)

    local skill_data = self:get_data(id)
    if not skill_data then
        ERROR_MSG("SkillSystem use %d skill cant find !!!", id)
        return
    end

    local owner = self:owner()

    local ret = self:check(SkillSystem.SKILL_CHECK_CASTER_DEATH, skill_data)
    if ret ~= 0 then
        ERROR_MSG("SkillSystem use check skill failed !!!")
        return
    end

    -- 检测是否加速

    -- 检测CD
    ret = self:check(SkillSystem.SKILL_CHECK_COLDDOWN, skill_data)
    if ret ~= 0 then
        ERROR_MSG("SkillSystem use check skill cd failed !!!")
        return
    end

    -- 检测


    -- 解析目标
    targets = {}

    -- 更新技能释放时间
    self:update_tick(skill_data, tick)

    -- 施放技能
    self:cast(skill_data, targets)
end
