-------------------------------------------------------------------------------
-- sync.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/gameentity")

--- 同步属性到客户端
function _M:sync_property_to_client(id, value, property)
    if self.base then
        self.base.sync_property(id, value)
    end
end

--- 同步其他玩家的属性给自己
function _M:sync_other_property_to_client(eid, id, value, property)
    if self.base then
        self.base.sync_other_property_to_client(eid, id, value)
    end
end

--- 同步属性到周围玩家
function _M:sync_property_to_other(id, value, property)
    local sp = self:get_space()
    if not sp then
        ERROR_MSG("GameEntity sync_property_to_other space is nil !!!")
        return
    end

    local view_list = sp.aoi:viewlist(self:get_id())
    if not viewlist then
        return
    end

    for k, v in pairs(view_list) do
        local entity = sp:get_entity(k)
        if entity then
            entity:sync_other_property_to_client(self:get_id(), id, value, property)
        end
    end

end

--- 同步属性
function _M:sync_property()
    --ERROR_MSG("GameEntity sync_property")
    for k, v in pairs(self.sync_property_ids) do
        local p = self.define.PropertyIndexs[k]
        if p then
            -- 更新到客户端
            if EntityFlag.is_client(p.Flags) then
                self:sync_property_to_client(k, self[p.Name], p)
            end

            -- 更新给周围的玩家
            if EntityFlag.is_other(p.Flags) then
                self:sync_property_to_other(k, self[p.Name], p)
            end
        end
    end

    self.sync_property_ids = {}
end

