-------------------------------------------------------------------------------
-- 技能buff
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

--------------------------------------------------------------------------------
local SkillSystem = require (_PACKAGE.."/system")

function SkillSystem:add_buff(id)
    return self.buff:add(id)
end


function SkillSystem:remove_buff(id)
    self.buff:remove(id)
end

-- 添加技能buff
function SkillSystem:add_skill_buff(skill_data)
    for k, id in ipairs(skill_data.learned_buffs) do
        if self:add_buff(id) ~= 0 then
            for i= 1, k - 1 do
                self:remove_buff(skill_data.learned_buffs[i])
            end

            return false
        end
    end
end


function SkillSystem:remove_skill_buff(skill_data)
    for k, id in ipairs(skill_data.learned_buffs) do
        if self:remove_buff(id) ~= 0 then
            for i= 1, k - 1 do
                self:add_buff(skill_data.learned_buffs[i])
            end

            return false
        end
    end

end

--- 更新技能相关的buff
function SkillSystem:update_skill_buff(skill_data, add)
    if add then
        return self:add_skill_buff(skill_data)
    else
        return self:remove_skill_buff(skill_data)
    end
end
