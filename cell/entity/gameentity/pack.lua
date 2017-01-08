-------------------------------------------------------------------------------
-- pack.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local cmsgpack = tengine.cmsgpack

local EntityFlag 	= require("lib.entity").flag

local _M = require (_PACKAGE.."/gameentity")

function _M:pack_client_property(t)
    t = t  or {}

    local def = self.define

	if not def then
        ERROR_MSG("GameEntity pack_client_property define is nil !!!")
		return t
	end

	t.id = self.id
    t.face = self.face
    t.pos = {self.pos[1], self.pos[2]}

	t.props = {}

	for index, p in ipairs(def.Properties) do
        local value = self[p.Name]
		if EntityFlag.is_client(p.Flags) and value ~= nil then
            if p.Type == "UINT8" or p.Type == "UINT32" then
                --ERROR_MSG(p.Name, self[p.Name])
                table.insert(t.props, {id = index, value = {uint_value = self[p.Name]}})
            elseif p.Type == "STRING" then
                table.insert(t.props, {id = index, value = {string_value = self[p.Name]}})
            elseif p.Type == "LUA_TABLE" then
                table.insert(t.props, {id = index, value = {blob_value = cmsgpack.pack(self[p.Name])}})
            else
            end
		end
	end

	return t
end

--- 打包其他人看到的属性
function _M:pack_other_property(t)
    t = t or {}

    local def = self.define

    if not def then
        ERROR_MSG("GameEntity pack_other_property define is nil !!!")
        return t
    end

    t.type = self.type
    t.id = self.id

    t.face = self.face
    t.pos = {self.pos[1], self.pos[2]}
	t.props = {}

	for index, value in ipairs(def.Properties) do
		if EntityFlag.is_other(value.Flags) then
            if value.Type == "UINT8" or value.Type == "UINT32" then
                table.insert(t.props, {id = index, value = {uint_value = self[value.Name]}})
            elseif value.Type == "STRING" then
                table.insert(t.props, {id = index, value = {string_value = self[value.Name]}})
            elseif value.Type == "LUA_TABLE" then
                table.insert(t.props, {id = index, value = {blob_value = cmsgpack.pack(self[value.Name])}})
            else
            end
		end
	end

	return t

end

--- 打包游戏逻辑属性
--- 用于下线时同步到网关服
function _M:pack_cell_property(t)
    t = t or {}

    local def = self.define

    if not def then
        ERROR_MSG("GameEntity pack_cell_property define is nil !!!")
        return t
    end

	t.props = {}

	for index, value in ipairs(def.Properties) do
		if EntityFlag.is_cell(value.Flags) and not EntityFlag.is_base(value.Flags) then
            if value.Type == "UINT8" or value.Type == "UINT32" then
                table.insert(t.props, {id = index, value = {uint_value = self[value.Name]}})
            elseif value.Type == "STRING" then
                table.insert(t.props, {id = index, value = {string_value = self[value.Name]}})
            elseif value.Type == "LUA_TABLE" then
                table.insert(t.props, {id = index, value = {blob_value = cmsgpack.pack(self[value.Name])}})
            else
            end
		end
	end

	return t
end

--- 打包AOI属性
function _M:pack_aoi_property(t)
    local sp = self:get_space()

    if not sp then
        ERROR_MSG("GameEntity pack_aoi_entity space nil !!!")
        return
    end

    t = t or {}

    t.type = self.type
    t.id = self.id
    t.face = self.face
    t.pos = {self.pos[1], self.pos[2]}

    t.aoi = {}

    --- 获取aoi
    local view_list = sp.aoi:viewlist()
    for k, v in pairs(view_list) do
        local entity = sp:get_entity(k)
        table.insert(t.aoi, entity:pack_other_property())
    end

    return t
end

--- 打包属性给客户端
function _M:pack_property_to_client()
    DEBUG_MSG("GameEntity pack_property_to_client")

    local t = self:pack_client_property()
    --ERROR_MSG(t)

    --self.base.pack_property_to_client(t)
    self.base.attached_cell(t)
end

--- 打包AOI属性列表给客户端
function _M:pack_aoi_to_client()
    local t = self:pack_aoi_property()
    self.base.pack_aoi_to_client(t)
end
