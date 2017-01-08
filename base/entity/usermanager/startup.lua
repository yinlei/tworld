--------------------------------------------------------------------------------
-- startup.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local table_length = table.length

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local EntityManager = require("lib.entity").manager
local global = require("base.core").global

local class = require "lib.middleclass"

local _M = require(_PACKAGE.."/usermanager")

function _M:init()
	DEBUG_MSG("UserManager:init")

    self.dbid_to_avatars = {}
	self.name_to_dbid = {}
    self.avatar_count = 0

	local succ = self:register_globally()

    if succ then
        self:on_registered()
    end
end

function _M:on_registered()
	DEBUG_MSG("UserManager.on_registered")

    self.name_to_dbid = {}

    --self:table_select("on_select_avatar_count_callback", "avatar", "select count(*) as 'id' from tbl_avatar")
    -- 载入玩家数据
end

-- 获取玩家数量
function _M:on_select_avatar_count_callback(rst)
    DEBUG_MSG("UserManager on_select_avatar_count_callback")

    -- rst = {{id = count}}
    if rst and #rst == 1 then
        self.avatar_count = rst[1].id or 0
    end

    if self.avatar_count == 0 then
        global.call("GameManager", "on_manager_loaded", "UserManager")
        return
    end

    local round = math.ceil(self.avatar_count / 1000)

    for i = 1, round do
        local sql = string.format("select * from tbl_avatar order by sm_level desc limit %d, %d", (i-1)*1000, 1000)

        self:table_select("on_select_avatar_callback", "avatar", sql)
    end

end

-- 获取一批玩家数据
function _M:on_select_avatar_callback(rst)
    for _, record in pairs(rst) do
        p(record)
        local avatar = self.dbid_to_avatars[record.id] or {}
        self.dbid_to_avatars[record.id] = avatar

        self.name_to_dbid[record.name] = record.id
    end

    local loaded_count = table.length(self.dbid_to_avatars)

    if self.avatar_count ~= loaded_count then
        return
    end

    INFO_MSG("UserManager on_select_avatar_callback avatar_count = %d .", self.avatar_count)

    -- TODO 排行榜

    self:notify_gamemanager_loaded()
end

-- 通知GameManager载入完成
function _M:notify_gamemanager_loaded()
    global.call("GameManager", "on_manager_loaded", "UserManager")
end

