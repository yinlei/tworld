-------------------------------------------------------------------------------
-- levelup.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local LevelData = require "data.level"

local _M = require (_PACKAGE.."/avatar")

--- 升级
function _M:levelup()
    local level = self.level

    local level_data = LevelData[level+1]
    if not level_data then
        return false
    end

    self.level = level + 1
    self.exp = 0

    self:on_levelup(level)

    return true
end

function _M:on_levelup(level)

end

--- 增加等级
function _M:add_level(value)
    if value > 0 then
        for i = 1, value do
            self:levelup()
        end
    end
end
