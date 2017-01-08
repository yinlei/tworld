-------------------------------------------------------------------------------
-- 释放技能
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

--------------------------------------------------------------------------------
local SkillSystem = require (_PACKAGE.."/system")


--- 释放技能
function SkillSystem:cast(skill_data, targets)
    local owner = self:owner()

    local action = self.action

    if skill_data.find_target_in_action == 0 then
        if not targets or targets.size() == 0 then
            --targets =
        end
    end

    local count = 0


    for _, id in ipairs(skill_data.actions) do
        --action:cast(skill_data, )
    end
end
