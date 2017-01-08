-------------------------------------------------------------------------------
-- property.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

--- 属性同步接口
function _M:process_base_property(base_props)
    DEBUG_MSG("Avatar process_base_property")

    local battle_props = table.copy(base_props)

    setmetatable(battle_props, {__index = function(t, k) return 0 end})

    --- 计算技能属性
    self.skill_system.buff:update_property(battle_props)

    self.battle_props = battle_props

    self.battle_props.old = base_props

    self:sync_battle_property(self.battle_props)
end

function _M:process_battle_property()
    local base_props = self.battle_props.old_session
end

function _M:sync_battle_property(t)
    DEBUG_MSG("Avatar sync_battle")
    for k, v in pairs(t) do
        if self[k] ~= nil then
            self[k] = v
        end
    end
end

--- base 同步过来的装备
function _M:sync_equipment(index, type)
    p("Avatar sync_equipment", index, type)
end
