-------------------------------------------------------------------------------
-- 检测技能
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local now = tengine.c.now

local LOG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG

local p = tengine.p

--------------------------------------------------------------------------------
local SkillSystem = require (_PACKAGE.."/system")

SkillSystem.static.SKILL_CHECK_COLDDOWN = 1
SkillSystem.static.SKILL_CHECK_LEARNED = 2
SkillSystem.static.SKILL_CHECK_DEPEND = 3
SkillSystem.static.SKILL_CHECK_CASTER_DEATH = 4
SkillSystem.static.SKILL_CHECK_CHARGE = 5
SkillSystem.static.SKILL_CHECK_RANGE = 6

--- 检测技能CD
function SkillSystem:check_colddown(skill_data, args)
    local last_skill_id = self.last_skill.id

    local last_skill_data = self.get_data(last_skill_id)

    if not last_skill_data then
        self.last_skill.id = 0
    else
        local id = skill_data.id

        local now_tick = args or now()
        -- 最少CD限制
        local elapsed_tick = now_tick - self.last_skill.tick
        if elapsed_tick < 100 then
            return 1
        end

        -- 自身技能CD
        elapsed_tick = now_tick - self.bag:get_cast_tick(skill_data)

        if elapsed_tick < skill_data.cd[1] then
            return 1
        end

        -- 公共CD
        if elapsed_tick < last_skill_data.cd[4] then
            return 2
        end

        return 0

    end
end

--- 检测技能是否已经习得
function SkillSystem:check_learned(skill_data)
    return self.bag:has(skill_data.id)
end

--- 检测技能

--- 检测施法者是否死亡

---

function SkillSystem:check(mode, skill_data, args)

end

