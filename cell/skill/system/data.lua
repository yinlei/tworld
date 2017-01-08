-------------------------------------------------------------------------------
-- 技能配置数据
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local LOG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG

local p = tengine.p
local SkillAction = require("cell.skill.action")
local SkillBag = require("cell.skill.bag")
local SkillBuff = require("cell.skill.buff")

--------------------------------------------------------------------------------
--- 技能配置数据
local data = {}

--------------------------------------------------------------------------------
local SkillSystem = require (_PACKAGE.."/system")

--- 载入配置
function SkillSystem:load()
    data = {}

	SkillAction:load()
	SkillBuff:load()
end

--- 获取指定id的技能配置数据
function SkillSystem:get_data(id)
    return data[id]
end

