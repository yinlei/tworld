-------------------------------------------------------------------------------
--  property.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local PropertySystem = require "base.system.property"

local _M = require (_PACKAGE.."/avatar")

--- 计算基础属性
function _M:process_base_property()
    local level = self.level
    local vocation  = self.vocation

    local base_props = {}

    self.base_props = PropertySystem.get_base_props(base_props, level)

    self.fight_force = PropertySystem.get_fight_force(base_props)

    self.gold = 10000

    DEBUG_MSG("Avatar process_base_property")
    self.cell.process_base_property(base_props)
end
