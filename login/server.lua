--------------------------------------------------------------------------------
-- server.lua
--------------------------------------------------------------------------------
local server = tengine.server

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local agent = require "agent"

local listener

local function on_accept(session)
    DEBUG_MSG("on_accept session %d", session)
    agent.new(listener, session)
end

local function on_read(session, data, size)
    DEBUG_MSG("on_read session %d data size %d", session, size)

    local a = agent.find(session)
    if not a then
        ERROR_MSG("can't find agent !!!")
        return
    end

    a:handler(data, size)
end

local function on_closed(session, err)
    DEBUG_MSG("on_closed session %d, error(%s)", session, err)
    local a = agent.find(session)
    if a then
        a:lost(session, err)
    end
end

local function listen(port)
    listener = server.new(port, on_accept, on_read, on_closed)
    return listener
end

return {
    listen = listen,
}
