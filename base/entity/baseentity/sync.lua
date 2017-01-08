-------------------------------------------------------------------------------
-- sync.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/baseentity")

--- 同步属性到客户端
function _M:sync_property_to_client(id, value, property)
    if self.client and self.agent then
        self.client.sync_property(id, value)
    end
end

--- 同步属性
function _M:sync_property()
    for k, v in pairs(self.sync_property_ids) do
        local p = self.define.PropertyIndexs[k]
        if p then
            self:sync_property_to_client(k, self[p.Name], p)
        end
    end

    self.sync_property_ids = {}
end

