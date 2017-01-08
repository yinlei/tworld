-------------------------------------------------------------------------------
-- skill.lua
-------------------------------------------------------------------------------
--[[
    技能流程
    client -> gate -> game
    技能都是在game中操作的 gate只是转发client的请求
]]--
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local LOG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG
local p = tengine.p

local RoleData = require "data.role"

local SkillSystem = require "base.system.skill"

local _M = require (_PACKAGE.."/avatar")

--- 初始化角色的技能
function _M:init_skill(vocation)
    vocation = vocation or self.vocation

    -- 获取角色配置
    local skill_data = RoleData[vocation].skills

    if not skill_data then
        return
    end

    local skills = {}

    for _, id in ipairs(skill_data) do
        skills[id] = 1
    end

    return skills
end

--- 升级技能
function _M:upgrade_skill(id, next_id)
    SkillSystem.upgrade(self, id, next_id)
end

--- 使用技能
function _M:use_skill(client_tick, x, y, face, id, targets)
    -- 转发到逻辑服
    self.cell.use_skill(client_tick, x, y, face, id, targets)
end

--- 吟唱技能
function _M:cast_skill(id, pos)
end
