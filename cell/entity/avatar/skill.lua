-------------------------------------------------------------------------------
-- skill.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

--- 学习技能
function _M:learn_skill(id)
    self.skill_system:learn(id)
end

function _M:unlearn_skill(id)
    self.skill_system:unlearn(id)
end

--- 施放技能
function _M:use_skill(client_tick, x, y, face, id, targets)
    if not self.skill_system then
        return
    end

    self:set_xy(x, y)
    self:set_face(face * 2)

    self.skill_system:use(id, targets, client_tick)
end