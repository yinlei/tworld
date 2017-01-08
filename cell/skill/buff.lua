-------------------------------------------------------------------------------
-- buff.lua
-------------------------------------------------------------------------------
local now = tengine.c.now

local ERROR_MSG = tengine.ERROR_MSG
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local p = tengine.p

local map = tengine.helper.map
local weakref = tengine.helper.weakref

local class = require "lib.middleclass"

--------------------------------------------------------------------------------
-- 配置数据
local data = {}

local SkillBuff = class("SkillBuff", weakref)

-- 载入配置
function SkillBuff:load()
    data = {}
end

--- 获取buff配置
function SkillBuff:get_data(id)
    return data[id]
end

function SkillBuff:initialize(owner, system)
    weakref.initialize(self, {owner = owner, system = system})

    --- 技能buff
    self.buffs = map:new()

    -- 属性影响
    self.attr_effects = map:new()

    -- 状态影响
    self.state_effects = map:new()

end

--- 载入avatar保存的技能buff
function SkillBuff:on_load()
    DEBUG_MSG("SkillBuff on_load")
    local owner = self:owner()

    local buffs = owner.saved_buffs
    if not buffs then
        ERROR_MSG("SkillBuff on_load no saved_buffs")
        return
    end

    self:clear()

    for id, info in pairs(buffs) do
        self:add(id, info[1], info[2])
    end

    self:load_buff_to_client()
end

--- 加载buff同步到客户端
function SkillBuff:load_buff_to_client()
    ERROR_MSG("SkillBuff locad_buff_to_client")
    local owner = self:owner()

    owner.client_buffs = {}

    local client_buffs = owner.client_buffs

    for id, buff in pairs(self.buffs) do
        local buff_data = self:get_data(id)
        if buff_data.show > 0 then
            local remain_tick = self:get_remain_tick(buff_data, buff.start_time.creat_time, self:get_elapse_tick(buff))

            if remain_tick < 0 then
                remain_tick = 0
            end

            client_buffs[id] = remain_tick
        end
    end
end

--- 保存avatar时保存技能buff
function SkillBuff:on_save()
    local buffs = {}

    for id, buff in pairs(self.buffs) do
        local buff_data = self:get_data(id)
        if buff_data.save_db then
            buffs[id] = {buff.start_time.create_time, self:get_elapse_tick(buff)}
        end
    end
end

--- avatar
function SkillBuff:on_die()

end

--- 获取技能buff过去的时间
function SkillBuff:get_elapse_tick(buff)
    local elapse_tick = now() - buff.start_time.sys_tick
    if elapse_tick < 0 then
        elapse_tick = 0
    end

    elapse_tick = elapse_tick + buff.start_time.buff_tick

    return elapse_tick
end

--- 获取技能buff剩余时间(负数表示无期限)
function SkillBuff:get_remain_tick(buff_data, create_time, elapse_tick)
    if buff_data.total_time == 0 then
        return -1
    end

    local remain_tick = buff_data.total_time - elapse_tick

    if buff_data.save_db == 1 then
        -- 按绝对时间计算
        remain_tick = buff_data.total_time - (os.time() - create_time) * 1000
    end

    if remain_tick < 0 then
        remain_tick = 0
    end

    return remain_tick
end

--- 是否存在技能buff
function SkillBuff:has(id)
    return self.buffs[id] ~= nil
end

--- 清空技能buff
function SkillBuff:clear()
    for id, _ in pairs(self.buffs) do
        self:delete(id)
    end
end

function SkillBuff:remove(id)
    return self:delete(id)
end

--- 删除指定buff
function SkillBuff:delete(id)
    local buff = self.buffs:find(id)

    if not buff then
        return
    end

    local owner = self:owner()

    -- 停止buff定时器
    if buff.stop_timer_id ~= 0 then
        self:ower():del_local_timer(buff.stop_timer_id)
        buff.stop_timer_id = 0
    end

    -- 删除激活技能的定时器
    for _, id in pairs(buff.skill_timer_ids) do
        self:ower():del_local_timer(id)
    end

    self:destory(id)
end


--- 创建一个buff对象
function SkillBuff:create(buff_data, creat_time, elapse_tick)
    local owner = self:owner()

    local stop_tick = self:get_remain_tick(buff_data, create_time, elapse_tick)

    if stop_tick == 0 then
        return nil
    end

    local start_time = {create_time = create_time, sys_tick = now(), buff_tick = elapse_tick}

    local buff = {create_time = create_time, stop_timer_id = 0, skill_timer_ids = {}}

    -- 设置buff停止定时器
    if buff_data.total_time > 0 and stop_tick > 0 then
        local stop_timer_id = owner:add_local_timer(stop_tick, 1, function(timer_id, buff_id)
                                                        self:destory(buff_id)
                                                                  end, buff_data.id)

        buff.stop_timer_id = stop_timer_id
    end

    -- 设置激活技能的定时器
    -- TODO

    return buff
end

--- 检测是否可以添加技能buff
function SkillBuff:check_add(buff_data)
    -- 1 检查是否存在互拆buff
    for _, id in pairs(buff_data.exclude_buff) do
        if self:has(id) then
            return false
        end
    end

    return true
end

--- 添加技能buf
function SkillBuff:add(id, create_time, elapse_tick)
    create_time = create_time or os.time()
    elapse_tick = elapse_tick or 0

    local buff_data = self:get_data(id)
    if not buff_data then
        return false
    end

    if not self:check_add(buff_data) then
        return false
    end

    local buff = self:create(buff_data, create_time, elapse_tick)

    if not buff then
        return false
    end

    -- 移除相同的buff
    self:delete(id)

    -- 覆盖buff
    for _, replace_id in pairs(buff_data.replace_buff) do
        self:delete(replace_id)
    end

    -- 更新技能buff属性效果
    self:update_attr_effect(buff_data, true)
    -- 更新技能buff状态效果
    self:update_state_effect(buff_data, true)

    -- 加入buff
    self.buffs:insert(id, buff)

    self:on_buff_start(buff_data)

    -- 广播

    -- 同步到客户端
    return true
end

--- 销毁指定buff对象
function SkillBuff:destory(id)
    local buff_data = self:get_data(id)

    if not buff_data then
        return
    end

    -- 更新技能属性效果
    self:update_property_effect(buff_data, false)
    -- 更新技能状态效果
    self:update_state_effect(buff_data, false)

    self.buffs:erase(id)

    self:on_buff_end(buff_data)

    -- 广播

    -- 更新到客户端
end

--- 合并属性表
function SkillBuff:update_property(t)
    for k, v in pairs(self.attr_effects) do
        if not t[k] then
            t[k] = v
        else
            t[k] = t[k] + self.attr_effects[k]
        end
    end

    return t
end

--- buff效果
function SkillBuff:update_property_effect(buff_data, is_add)
    local property_effect = buff_data.property_effect or {}

    for k, v in pairs(property_effect) do

    end
end

--- buff状态
function SkillBuff:update_state_effect(buff_data, is_add)

end

--- buff事件
function SkillBuff:on_buff_start(buff_data)
    -- TODO
end

function SkillBuff:on_buff_end(buff_data)
    -- TODO
end

return SkillBuff
