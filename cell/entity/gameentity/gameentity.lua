--------------------------------------------------------------------------------
-- gameentity.lua
--------------------------------------------------------------------------------
local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local class = require("lib.middleclass")

local super = require("lib.entity").entity
local flag = require("lib.entity").flag

local _M = class("GameEntity", super)

function _M:initialize(type, id)
	super.initialize(self, type, id)

    self.sub_type = 0

	self.space_id = 0

	self.entity_ids = {}

	self.is_base  = false

	self.pos = {0, 0}

	self.face = 0

	self.speed = 60

    --- 上次移动时间戳用于检测
	self.last_move_tick = 0

    local mt = getmetatable(self)
    mt.__newindex = function(t, k, v)
        rawset(t, k, v)
        if not t.define then
            return
        end

        local p = t.define.Properties[k]
        if not p then
            return
        end

        if p.Persistent then
            rawset(t, is_dirty, true)
        end

        if  not flag.is_base(p.Flags) and p.Type ~= 'LUA_TABLE' then

            -- 更新到客户端
            if flag.is_client(p.Flags) then
                local id = p.PropertyIndexs[p.name]

                rawset(t.sync_attribut_ids, id, 1)
            end

            -- 更新给周围的玩家
            if flag.is_other(p.Flags) then
                local id = p.PropertyIndexs[p.name]

                rawset(t.sync_attribut_ids, id, 1)
            end
        end

    end
end

-- 逻辑的实体特有的初始化
function _M:init()
	-- body
end

--- 解析实体属性
function _M:parser(properties)
    properties = properties or self.define.Properties

	if not properties then
        ERROR_MSG("Entity parser property is nil !!!")
		return
	end

	for _, value in ipairs(properties) do
		if value.Flags and flag.is_cell(value.Flags) then
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

--- 设置坐标
function _M:set_xy(x, y)
    self.pos = {x, y}
end

--- 获取坐标
function _M:get_xy()
    return self.pos[1], self.pos[2]
end

-- 激活
function _M:active()

end

-- 设置网关代理
function _M:set_base(base)
	self.base = base
end

function _M:on_destory()
	-- body
end

return _M 
