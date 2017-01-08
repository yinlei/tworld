-------------------------------------------------------------------------------
-- 仓库系统 生成道具ID
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

--------------------------------------------------------------------------------
local InventorySystem = require(_PACKAGE.."/inventory")

-- 生成道具实例ID
function InventorySystem:get_uid()
    local uid = self.uid
    local time = os.time()
    if uid <= time then
        uid = time + 1
        self.uid = uid
    else
        uid = uid + 1
        self.uid = uid
    end

    return uid
end

