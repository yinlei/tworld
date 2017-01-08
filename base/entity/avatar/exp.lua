-------------------------------------------------------------------------------
-- exp.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local LevelData = require "data.level"

local _M = require (_PACKAGE.."/avatar")

--- 增加经验
function _M:add_exp(exp, ...)
    if exp == 0 then
        return
    end

    local level = self.level

    -- 是否为最高级
    if not LevelData[level + 1] then
        return
    end

    local _exp = self.exp + exp

    local level_data = LevelData[level]

    if not level_data then
        return
    end

    if _exp >= level_data.next_level_exp then
        if self:levelup() then
            self:add_exp(_exp-level_data.next_level_exp, ...)
        else
            self.exp = _exp
        end
    end
end
