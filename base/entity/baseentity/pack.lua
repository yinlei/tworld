-------------------------------------------------------------------------------
-- pack.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local LOG_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local cmsgpack = tengine.cmsgpack

local flags = require ("lib.entity").flag

local _M = require (_PACKAGE.."/baseentity")

function _M:pack_client_property()
    local def = self.define

	if not def then
        ERROR_MSG("Entity pack_to_client define is nil !!!")
		return nil
	end

	local t = {}
	t.type = self.type
	t.id = self.id
	t.db_id = self.db_id
	t.name = self.type_name
	t.props = {}

	for index, value in ipairs(def.Properties) do
		if flags.is_client(value.Flags) and self[value.Name] ~= nil then
            if value.Type == "UINT8" or value.Type == "UINT16" or value.Type == "UINT32" then
                table.insert(t.props, {id = index, value = {uint_value = self[value.Name]}})
            elseif value.Type == "STRING" then
                table.insert(t.props, {id = index, value = {string_value = self[value.Name]}})
            elseif value.Type == "LUA_TABLE" or value.Type == "TABLE" then
                table.insert(t.props, {id = index, value = {blob_value = cmsgpack.pack(self[value.Name])}})
            else
                ERROR_MSG("BaseEntity pack_client_property unknown name: %s, type %s", value.Name, value.Type)
            end
		end
	end

	return t
end

function _M:pack_cell_property()
    local def = self.define

	if not def then
        ERROR_MSG("Entity pack_cell_property define is nil !!!")
		return nil
	end

	local t = {}

	for index, p in ipairs(def.Properties) do
		if flags.is_base(p.Flags) and flags.is_cell(p.Flags) then
            t[p.Name] = self[p.Name]
		end
	end

	return t
end
