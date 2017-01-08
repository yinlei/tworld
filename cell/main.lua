-------------------------------------------------------------------------------
-- cell
-------------------------------------------------------------------------------
local T = require "tengine"

require "cell.entity"

local actor = tengine.actor
local timer = tengine.timer

local conf = require "config"
local cmd	= require "cell.cmd"
local cell = require "cell"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local function command(command, ...)
	local f = assert(cmd[command])
	return f(...)
end

local function main(...)
    cell.init(...)

	actor.start(command)

    local global = actor.sync("global")

    local succ, ret = global.register_service("cell", actor.self())
    if succ and ret == 0 then
        INFO_MSG("register to global success ...")
    else
        ERROR_MSG("rgister to global failed !!!")
    end

    local function gc()
        collectgarbage()
        collectgarbage()
        timer.callback(100, gc)
    end

    timer.callback(100, gc)


    INFO_MSG("cell service started ...")
end

T.start(main, conf)
