-------------------------------------------------------------------------------
-- 仓库系统 添加物品
-------------------------------------------------------------------------------
local _PACKAGE      = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local EntityManager = require "lib.entity".manager

local InventorySystem = require(_PACKAGE.."/inventory")

-- 配置文件
local RoleData = require "data.role"
local ItemData = require "data.item"

--- 初始化角色普通道具
function InventorySystem:init_general_items(items)
    -- 检查是否有空间

    for id, count in pairs(items) do
        self:add_item(id, count)
    end
end

---
function InventorySystem:init_items_for_avatar(vocation, dbid)
    local role_data = RoleData[vocation]
    if not role_data then
        ERROR("role data is null !!!")
        return false
    end

    local items = role_data.items
    local bodys = role_data.body_equips

    if bodys then
        if not self:init_equipment_items(bodys, dbid) then
            ERROR("InventorySystem init_equipment_items failed!!!")
            return false
        end
    end

    if items then
        self:init_general_items(items)
    end

    self:update_avatar(dbid)
end

--- 更新角色信息到角色列表
function InventorySystem:update_avatar(dbid)
    local avatar = self:avatar()

    local account = EntityManager.entity(avatar.account_id)
    if not account then
        return false
    end

    local ret = account:update_avatar_info(avatar, dbid)
    if ret ~= 0 then
        return false
    end

    account:write_to_db(function()
            INFO("account write_to_db ok !!!")
    end)

    if account:has_client() then
        account.client.OnCreateCharacterResp(0, dbid)
    end
end
