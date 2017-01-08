-------------------------------------------------------------------------------
-- friend.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local _M = require (_PACKAGE.."/avatar")

-- 获取好友列表
function _M:FriendListReq()
    local system = self.friend_system

    if system then
        system:friend_list()
    end
end

-- 添加好友
function _M:FriendAddReq(dbid)
    if dbid == self.dbid then
        return
    end

    if self.friend_system:is_full() then
        return
    end

    if self.friend_system:is_friend(dbid) then
        return
    end

    self.friend_system:add_friend(dbid)
end

-- 删除好友
function _M:FriendDelReq(dbid)

end

-- 查询好友
function _M:FriendResearchReq(name)
    self.friend_system:search(name)
end

-- 接受好友
function _M:FriendAcceptReq(dbid)

end

-- 拒绝好友
function _M:FriendRejectReq(dbid)

end