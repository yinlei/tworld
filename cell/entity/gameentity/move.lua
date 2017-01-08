-------------------------------------------------------------------------------
-- move.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/gameentity")

--- 移动
function _M:move(face, x, y, z)
    -- 检测
    if self.last_move_tick > 0 then
    end

    local pos  = self.pos

    pos[1], pos[2] = x, y

    self.face = face

    local space  = self:get_space()

    if not space then
        ERROR("GameEntity move cant find space !!!")
        return
    end

    -- local enter_self, enter_other, leave_self, leave_other = space.aoi:update(self.id, {x = x, y = y})
    -- p(enter_self, enter_other, leave_self, leave_other)
    -- -- TODO 广播(是否要优化成定时分发)

    -- 分发自己的信息给周围玩家
    -- for _, id in pairs(enter_self) do
    -- end

    -- 分发周围玩家给自己
    -- for _, id in pairs(enter_other) do
    -- end

    -- 删除周围不可见的玩家
    -- for _, id in pairs(leave_self) do
    -- end

    -- 删除看不见自己的
end
