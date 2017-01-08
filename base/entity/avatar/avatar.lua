--------------------------------------------------------------------------------
-- avatar.lua
--------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local EntityManager = require("lib.entity").manager
local class = require "lib.middleclass"

local super = require "base.entity.baseentity"

local TaskSystem = require("base.system.task")
local ActivitySystem = require("base.system.activity")
local FriendSystem = require("base.system.friend")
local InventorySystem = require("base.system.inventory")

local _M = class("Avatar", super)

function _M:init()
	-- 初始化系统
    self.task_system = TaskSystem:new(self)
    self.activity_system = ActivitySystem:new(self)
    self.friend_system = FriendSystem:new(self)
    self.inventory_system = InventorySystem:new(self)

end

function _M:create(account, name, gender, vocation)
    -- 基础信息
	self.name = name
	self.vocation = vocation
	self.gender = gender
	self.account_name = account.name
	self.account_id = account.id
	self.create_time = os.time()

	-- 场景信息
	self.scene_id = 10004
	self.map_x = 0
	self.map_y = 0
    self.imap_id = 0

	-- 初始等级
	self.level = 1

    -- 初始化任务
    self.task = 10000

	-- 装备
    self.equipments = {}

    -- 技能
    self.skills = self:init_skill(vocation)
end

return _M
