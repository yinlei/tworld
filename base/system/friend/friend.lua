-------------------------------------------------------------------------------
-- friend.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local class = require "lib.middleclass"

local global = require("base.core").global

local System = require("base.system.system")

local FriendSystem = class("FriendSystem", System)

function FriendSystem:initialize(owner)
    System.initialize(self, owner)
end

--------------------------------------------------------------------------------
-- 添加好友
function FriendSystem:add_friend(dbid)

end

--------------------------------------------------------------------------------
-- 获取好友数量
function FriendSystem:get_friend_count()
    local avatar = self:avatar()
    if avatar and avatar.friends then
        return table.length(avatar.friends)
    end

    return 0
end

--------------------------------------------------------------------------------
-- 好友列表
function FriendSystem:friend_list()
    local friend_dbids = self:owner().friends

    -- 通过UserManager获取好友的详细信息
    global.call("UserManager", "query_info_by_player_dbids",
                self:avatar().base_service, 1, friend_dbids, {})
end

--------------------------------------------------------------------------------
-- 发送好友信息
function FriendSystem:send_all_friend(friend_infos)
    local avatar = self:avatar()

    if not friend_infos or table.length(friend_infos) < 1 then
        avatar.client.OnFriendListResp({}, 1)
        return
    end

    local infos = {}

    for _, info in pairs(friend_infos) do
        if not info.id then
            return
        end
    end

    avatar.client.OnFriendListResp(infos, 0)
end

--------------------------------------------------------------------------------
-- 查询好友
function FriendSystem:search(name)
    -- 通过UserManager查询
    global.call("UserManager", "query_info_by_player_name", self:avatar().base_service, 2, name)
end

--------------------------------------------------------------------------------
-- 好友是否已经满了
function FriendSystem:is_full()
    -- 获取配置好友的最大数量
    local limit = 20

    if table.length(self.friends) >= limit then
        return true
    end

    return false
end

--------------------------------------------------------------------------------
-- 是否已经是好友
function FriendSystem:is_friend(dbid)
    local avatar = self:avatar()

    if avatar.friends[dbid] then
        return true
    end

    return false
end

-- TODO

return FriendSystem
