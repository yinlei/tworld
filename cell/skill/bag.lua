-------------------------------------------------------------------------------
-- bag.lua
-------------------------------------------------------------------------------
local now = tengine.c.now

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local map = tengine.map
local weakref = tengine.helper.weakref

local class = require "lib.middleclass"
--------------------------------------------------------------------------------
local SkillBag = class("SkillBag", weakref)

function SkillBag:initialize(owner, system)
    weakref.initialize(self, {owner = owner, system = system})

    -- 技能
    self.skills = owner.skills
    -- 技能使用时间 用于CD计算
    self.skill_cast_ticks = map:new()
end

--- 添加技能
function SkillBag:add(id)
    if self:has(id) then
        return false
    end

    self.skills[id] = 1
    self:sync()
end

--- 删除技能
function SkillBag:remove(id)
    self.skills[id] = nil
    self:sync()
end

--- 技能是否存在
function SkillBag:has(id)
    return self.skills[id] == 1
end

--- 同步技能列表
function SkillBag:sync()
    local owner = self:ref("owner")

    if not owner then
        return
    end

    owner.base.SkillBagSyncToBase(self.skills)
end

--- 标记技能使用时间
function SkillBag:update_cast_tick(skill_data, tick)
    if not tick then
        tick = now()
    end

    --self.skill_cast_ticks[skill_data.id] = tick
    self.skill_cast_ticks:replace(skill_data.id, tick)
end

--- 获取指定技能最近使用的时间
function SkillBag:get_cast_tick(skill_data)
    return self.skill_cast_ticks[skill_data.id] or 0
end

--- 重置技能使用时间
function SkillBag:reset_cast_tick()
    self.skill_cast_ticks:clear()
end

return SkillBag
