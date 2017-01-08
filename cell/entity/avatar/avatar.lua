--------------------------------------------------------------------------------
-- avatar.lua
--------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local class = require("lib.middleclass")
local super = require("cell.entity.gameentity")

local SkillSystem = require("cell.skill").SkillSystem

local _M = class("Avatar", super)

function _M:initialize(...)
    super.initialize(self, ...)

    self.hp = 0
    self.attack = 0
    self.defense = 0
end

-- 初始化
function _M:init()
	self.sub_type = 0

	self:set_speed(10)

	self.skill_system = SkillSystem:new(self)

    self.skill_system:on_load()


    self.last_move_tick = 0
end

-- 销毁
function _M:on_destory()
    -- 保存技能
    self.skill_system:on_save()
end

return _M 
