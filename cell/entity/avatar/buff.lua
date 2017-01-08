-------------------------------------------------------------------------------
-- buff.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

function _M:add_buff(id)
    self.skill_system.buff:add(id)
end

function _M:delete_buff(id)
    if id > 0 then
        self.skill_system.buff:delete(id)
    else
        self.skill_system.buff.clear()
    end
end
