--------------------------------------------------------------------------------
-- baseentity.lua
--------------------------------------------------------------------------------
local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local class = require "lib.middleclass"
local super = require "lib.entity".entity
local flags = require "lib.entity".flag

local keys = require("base.core").key

local _M = class("BaseEntity", super)

function _M:initialize(type, id, args)
	super.initialize(self, type, id, args)

	self.cell_state = 0
	self.cell_service = 0
	self.client_session = 0
	self.has_client = false

	self.cell_datas = {}

	self.is_base  = true

    self.property = setmetatable({owner = self}, 
		{__newindex = function(t, k, v)
			local entity = t.owner

			entity[k] = v

			local define = entity.define
			local p = define.PropertyNames[k]

			if not p then
				return
			end

			if p.Persistent then
				entity.is_dirty = true
			end
			-- 更新到客户端
			if  flags.is_client(p.Flags) and p.Type ~= 'LUA_TABLE' then
				entity.sync_property_ids[p.Index] = 1
			end
		end, __mode = 'kv'})

end

function _M:create()
	return 0
end

-- 解析实体属性
function _M:parser(properties)
    properties = properties or self.define.Properties

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


function _M:pickle()
	local property = {}

	property.type = self:type()
	property.id = self:id()
	property.db_id = self:dbID()
	property.props = {}

	return property
end

-- 注册实体为全局可见
function _M:register_globally()
    local global = actor.wrap("global")
    local succ, ret = global.register_globally(self.type_name, self.service)
    if not succ or ret ~= 0 then
        ERROR_MSG(self.type_name .. " register global failed !!!")
        return false
    end

    return true
end

function _M:register_cross_server( ... )
	-- body
end

function _M:notify_client_to_attach(account)
	DEBUG("BaseEntity.notify_client_to_attach id = %d, account = %s" , self.id, account)

	local key = keys.key(account, self.id)

	actor.rpc("login", "notify_client_to_attach", account, key, SERVICE.address)
end

function _M:notifyClientMultiLogin( ... )
	-- body
end

--多个客户端连接的回调方法
function _M:onMultiLogin()
    --Debug("BaseEntity.onMultiLogin", string.format("id=%d", self:getId()) )
end

--
function _M:onDestroy()
    --Debug("BaseEntity.onDestroy", string.format("id=%d", self:getId()))
end

-- sql select
function _M:table_select(callback, table_name, sql)
	local function __callback__(ret)
		if type(callback) == "function" then
			callback(self, ret)
		elseif type(callback) == "string" then
			local f = assert(self[callback])
			f(self, ret)
		else
			ERROR_MSG("BaseEntity table_select callback error!!!")
		end
	end
	actor.callback("db", __callback__, "table_select", table_name, sql)
end

function _M:table_insert()
    -- TODO
end

function _M:table_execute()
    -- TODO
end

return _M
