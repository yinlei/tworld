-------------------------------------------------------------------------------
-- property.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local math_ceil = math.ceil

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local LevelData = require "data.level"
local EffectData = require "data.effect"
local FightForceData = require "data.fightforce"

--------------------------------------------------------------------------------
local PropertySystem = {}

--- 计算战力
function PropertySystem.get_fight_force(base_props)
    local fight_force = 0

    for k, v in pairs(FightForceData) do
        fight_force = fight_force + base_props[k]*v
    end

    fight_force = math_ceil(fight_force)
    return fight_force
end

--- 基础属性
function PropertySystem.get_base_props(t, level)
    if not t then
        return nil
    end

    setmetatable(t, {__index = function(t, k)
                        return 0
    end})

    -- 等级
    local effect_id = LevelData[level].effect_id
    if not effect_id then
        return t
    end

    local effect_data = EffectData[effect_id] or {}
    for k, v in pairs(effect_data) do
        t[k] = t[k] + v
    end

    -- 装备

    return t
end


return PropertySystem
