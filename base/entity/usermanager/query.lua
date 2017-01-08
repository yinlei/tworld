-------------------------------------------------------------------------------
-- query.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local RpcWrap = require("lib.entity").rpc

local _M = require(_PACKAGE.."/usermanager")

-- 查找玩家信息
function _M:query_info_by_player_dbids(service, id, dbids, fields)
    local ret = {}

    for _, dbid in pairs(dbids) do
        local player_info  = self.dbid_to_avatars[dbid]

        local record = {}

        for _, k in pairs(fields) do
            record[k] = player_info[k]
        end

        ret[#ret+1] = record
    end

    -- 回调
    local service_entity = RpcWrap(service)
    if service_entity then
         service_entity.query_info_by_player_dbids_callback(id, 0, ret)
    end
end

-- 通过名字查找
function _M:query_info_by_player_name(server, id, name)
    local service_entity = RpcWrap(server)
    if not service_entity then
        return
    end

    local dbid = self.name_to_dbids[name]

    if dbid then
        local avatar_info = self.dbid_to_avatars[dbid]
        if avatar_info then
            service_entity.query_info_by_player_name_callback(id, name, avatar_info)
            return
        end
    end

    service_entity.query_info_by_player_name_callback(id, name, {})
end

-- 通过id查找
function _M:query_info_by_player_id(server, id, dbid)
    local service_entity = RpcWrap(server)
    if not service_entity then
        return
    end

    local avatar_info = self.dbid_to_avatars[dbid]
    if avatar_info then
        service_entity.query_info_by_player_name_callback(id, dbid, avatar_info)
        return
    end

    service_entity.query_info_by_player_name_callback(id, dbid, {})
end

