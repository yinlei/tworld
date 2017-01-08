-------------------------------------------------------------------------------
-- client.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local client = require "base.core.client"

local attached = require "packet.attached"

local _M = require (_PACKAGE.."/baseentity")

function _M:setClientSession(session)
	self.client_session = session
end

function _M:clientSession()
	if not self.datas["client"] then
		return 0
	end

	return self.client_session
end

function _M:give_client(agent)
	local session = agent.session

	INFO_MSG("BaseEntity.give_client session = " .. session)

	self.agent = agent

    self.client = client.new(agent, self.define, self.id)

    INFO_MSG("notify client attached ...")

    agent:send(attached, self.type_name, self:pack_client_property())

	self:on_client_get_base()

end

function _M:remove_client()
	self.has_client = false

	self.client = nil

	if self.cell_service then
		-- 通知cell

	end

	if self.on_client_lost then
		self:on_client_lost()
	end
end

function _M:give_client_to( entity )
    DEBUG_MSG("give client to %s", entity.type_name)
    if not entity then
        ERROR_MSG("BaseEntity give_client_to entity is nil")
    end

    entity:give_client(self.agent)

    self.agent:attach(entity)
end

-------------------------------------------------------------------------------
--客户端连接到entity的回调方法
function _M:on_client_get_base()
    -- overwrite
end

--客户端断开连接的回调方法
function _M:on_client_lost()
    -- overwrite
end

