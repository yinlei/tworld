-------------------------------------------------------------------------------
-- move.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/avatar")

--- 移动
function _M:move(face, x, y)
    p("Avatar move ", face, x, y)
    -- 检测
    if self.last_move_tick > 0 then
    end

    self.face = face
    self.pos[1], self.pos[2] = x, y

    -- 同步

end
