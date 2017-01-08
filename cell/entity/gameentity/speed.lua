-------------------------------------------------------------------------------
-- 速度
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local LOG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG

local p = tengine.p

--------------------------------------------------------------------------------
local GameEntity = require (_PACKAGE.."/gameentity")


-- 速度
function GameEntity:set_speed(speed)
    self.speed = speed
end

function GameEntity:get_speed()
    return self.speed
end

