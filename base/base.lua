--------------------------------------------------------------------------------
-- base.lua
--------------------------------------------------------------------------------
local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local server = require "server"
local db = require "db"
local cmd	= require "base.cmd"

local function command(command, ...)
	local f = assert(cmd[command])
	return f(...)
end

return function(conf)
    local listener = server.listen()

    INFO_MSG("start listener on %s ...", listener:localaddress())

    db.init(conf)

    INFO_MSG("db init success ..")

    actor.start(command)

    local global = actor.sync("global")

    INFO_MSG("ready to register to global ...")
    local succ, ret = global.register_service("base", actor.self())
    if succ and ret == 0 then
        INFO_MSG("register to global success ...")
    else
        ERROR_MSG("rgister to global failed !!!")
    end

end
