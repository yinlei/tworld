-------------------------------------------------------------------------------
-- 技能系统
-------------------------------------------------------------------------------
local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local WeakRef = tengine.helper.weakref

local class = require "lib.middleclass"

local SkillAction = require("cell.skill.action")
local SkillBag = require("cell.skill.bag")
local SkillBuff = require("cell.skill.buff")

--------------------------------------------------------------------------------
local SkillSystem = class("SkillSystem", WeakRef)

function SkillSystem:initialize(owner)
    WeakRef.initialize(self, {owner = owner})

    -- 技能配置
    self.data = data

    -- 上次使用技能
    self.last_skill = {id = 0, count = 0, tick = 0}

    -- 吟唱技能
    --self.

    -- action
    self.action = SkillAction:new(owner, self)
    self.buff = SkillBuff:new(owner, self)
    self.bag = SkillBag:new(owner, self)

    -- 当前连击计数
    self.hit_combo = {count = 0, last_tick = 0}

end

---
function SkillSystem:on_load()
    self.buff:on_load()
end

function SkillSystem:on_save()
    self.buff:on_save()
end

function SkillSystem:clear()
    self.action:clear()
    self.buff:clear()
end

return SkillSystem
