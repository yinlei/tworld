-------------------------------------------------------------------------------
-- data.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local LOG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG

local p = tengine.p

--------------------------------------------------------------------------------
--- 技能动作配置数据
local data = require "data.skill_action"

--------------------------------------------------------------------------------
local SkillAction = require (_PACKAGE.."/action")

--- 载入配置
function SkillAction:load()
end

--- 获取指定id的技能配置数据
function SkillAction:get_data(id)
    return data[id]
end

--- 获取动作
