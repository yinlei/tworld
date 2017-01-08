-------------------------------------------------------------------------------
-- 学习技能
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local LOG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG

local p = tengine.p

--------------------------------------------------------------------------------
local SkillSystem = require (_PACKAGE.."/system")

--- 学习技能
function SkillSystem:learn(id)
    local skill_data = self:get_data(id)
    if not skill_data then
        return false
    end

    if self.bag:has(id) then
        return false
    end

    if self:add_skill_buff(skill_data) then
        if self.bag:add(id) then
            self:remove_skill_buff(skill_data)
            return false
        end
    end

    return true
end

--- 取消学习的技能
function SkillSystem:unlearn(id)
    local skill_data = self:get_data(id)

    if not skill_data then
        return false
    end

    if not self.bag:has(id) then
        return false
    end

    if self:remove_skill_buff(skill_data) then
        if not self.bag:remove(id) then
            self:add_skill_buff(skill_data)
            return false
        end
    end

    return true

end
