-------------------------------------------------------------------------------
-- entity.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local pairs, tonumber, tostring = pairs, tonumber, tostring
local string_sub = string.sub
local table_insert = table.insert

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local WARNING_MSG = tengine.WARNING_MSG
local INFO_MSG = tengine.INFO_MSG
local p = tengine.p

local cmsgpack = tengine.cmsgpack

local Emitter = tengine.Emitter

local defines = require(_PACKAGE .. "/define")
local types = require(_PACKAGE .. "/type")
local flags = require(_PACKAGE .. "/flag")

local timer = require(_PACKAGE .. "/timer")

local class = require "lib/middleclass"

local _M = class("entity")

function _M:initialize(type, id, args)
    tengine.p("entity initialize ", type, id, args)

	self.type = type

	self.id = id

	self.db_id = 0

	self.is_base = false

	self.is_dirty = false

	self.is_mysql_dirty = false

	local name = types.name(self.type)

	if not name then
        ERROR_MSG("entity can't find type %d", self.type)
		return
	end

	self.type_name = name
    tengine.p(name)
	local _define = defines.get(name)
	if not _define then
        ERROR_MSG("entity can't get define !!!")
		return
	end

	self.define = _define
	self.service = {}
	self.service["type"] = self.type
	self.service["id"] = self.id
	self.service["name"] = self.type_name
	self.service["service"] = actor.self()

    self.timer = timer.new(100)

    self.event = Emitter:new()

    self.sync_property_ids = {}
    self.sync_timer_id = self:add_local_timer(200, 0,
                                              function()
                                                  if self.sync_property then
                                                      self:sync_property()
                                                  end
    end)

	self:parser(_define.Properties)

	tengine.p("create ok  ", self.type_name)
end

function _M:init()
	-- TODO
end

function _M:get_type()
	return self.type
end

function _M:get_id()
	return self.id
end

function _M:set_dbid(id)
	self.db_id = id
end

function _M:get_dbid()
	return self.db_id
end

function _M:get_service()
	return self.service
end

function _M:update_property(data)
	local define = self.define

	data = data or {}
	for key, value in pairs(data) do
		if string_sub(key, 1, 2) == 'sm' then
			key = string_sub(key, 4, -1)
		end

		local property = define.PropertyNames[key]
		if property then
			if property.Type == "LUA_TABLE" then
				self[key] = cmsgpack.unpack(value)
				p("update_property", key, self[key])
			else
				self[key] = value
			end
		end
	end
end

function _M:update_property_with_db(db_id, data)
	self.db_id = db_id

	sefl.update_property(data)
end

function _M:parser(properties)
	if not properties then
        ERROR_MSG("Entity parser property is nil !!!")
		return
	end

	for _, value in ipairs(properties) do
		if value.Flags and flags.is_base(value.Flags) then
			if value.Type == "UINT8" or value.Type == "UINT32" or value.Type == "UINT16" or value.Type == "UINT64" or
				value.Type == "INT8" or value.Type == "INT32" or value.Type == "INT16" or value.Type == "INT64"	or value.Type == "FLOAT" then
				if value.Default then
					self[value.Name] = tonumber(value.Default)
				else
					self[value.Name] = 0
				end
			elseif value.Type == "STRING" or value.Type == "BLOB" then
				self[value.Name] = value.Default or ""
			elseif value.Type == "TABLE" or value.Type == "LUA_TABLE" or value.Type == "LUA_OBJECT" then
				self[value.Name] = value.Default or {}
			else
				p("unknown type %s!!!", value.Type)
			end
		end
	end

end

function _M:pack_to_db()
    local _define = self.define
	if not _define then
        ERROR_MSG("Entity pack_to_db no entity define !!!")
		return nil
	end

	local t = {}

	for _, value in ipairs(_define.Properties) do
		if value.Persistent then
			t[value.Name] = self[value.Name]

			if value.Type == "LUA_TABLE" then
				t[value.Name] = cmsgpack.pack(self[value.Name])
			end
		end
	end

	return t
end

function _M:write_to_db(db, model)
    local attrs = self:pack_to_db()

    if self.db_id ~= 0 then
        attrs.id = tostring(self.db_id)
    end

    local db_id = assert(model:save(db, attrs))

	self.time_stamp = os.time()
	self.is_dirty = false
	self.is_mysql_dirty = false

    return db_id
end


function _M:add_timer(start, interval, args)
    local count = 1
    if interval > 0 then
        count = 0
    end

    local timer_id = self:add_local_timer(start, interval, count, function(id, args)
                             if type(self.on_timer) == "function" then
                                 self:on_timer(id, args)
                             end
    end, args)

    return timer_id
end

function _M:del_timer(id)
    self:del_local_timer(id)
end

function _M:add_local_timer(interval, count, ...)
    local _timer = self.timer
    if _timer then
        return _timer:add(interval, interval, count, ...)
    end

    return 0
end

function _M:del_local_timer(id)
    local _timer = self.timer
    if _timer then
        _timer:del(id)
    end
end

function _M:once(name, callback)
    local _event = self.event
    if _event then
        _event:once(name, callback)
    end
end

function _M:on(name, callback)
    local _event = self.event
    if _event then
        _event:on(name, callback)
    end
end

function _M:emit(name)
    local _event = self.event
    if _event then
        _event:emit(name)
    end
end

return _M
