-------------------------------------------------------------------------------
-- hp.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local math_ceil = math.ceil

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

function _M:add_hp(value)
    value = math_ceil(value)

    local current_hp = self.current_hp

    if current_hp <= 0 then
        if current_hp + value > 0 then
            current_hp = current_hp + value
            if current_hp > self.hp then
                current_hp = self.hp
            end

            self.current_hp = current_hp

            self:check_death()
        end
    elseif current_hp > 0 then
        if current_hp + value <= 0 then
            current_hp = 0
            self.current_hp = current_hp

            self:check_death()
        elseif current_hp + value > self.hp then
            self.current_hp = self.hp
        else
            self.current_hp = current_hp + value
        end
    end

end

--- 设置HP
function _M:set_hp(value)
    local current_hp = self.current_hp

    if value < 0 then value = 0 end

    if current_hp <= 0 and value > 0 then
        -- 复活
        self.current_hp = value
        self:check_death()

    elseif current_hp > 0 and value == 0 then
        self.current_hp = value
        self:check_death()
    else
        self.current_hp = value
    end
end

--- 判定是否死亡
function _M:is_death()
    return self.current_hp > 0
end

--- 检测是否死亡
function _M:check_death()
    local current_hp = self.current_hp

    if current_hp > 0 then
        -- 状态设置
    else

    end
end
