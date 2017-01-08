-------------------------------------------------------------------------------
-- main.lua
-- TODO reids->mysql
-------------------------------------------------------------------------------
local T = require "tengine"

local INFO_MSG = T.INFO_MSG

local actor = T.actor
local timer = T.timer

local conf = require "config"
local cmd	= require "store.cmd"

local function command(command, ...)
	local f = assert(cmd[command])
	return f(...)
end

local function main(...)
	actor.start(command)
    local function gc()
        collectgarbage()
        collectgarbage()
        timer.callback(500, gc)
    end

    timer.callback(500, gc)

	INFO_MSG("store service started ...")
end

T.start(main, conf)
