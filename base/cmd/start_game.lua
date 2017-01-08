--------------------------------------------------------------------------------
-- start_game.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local factory = require("base.core").factory

local  _M = {}

function _M.command()
    DEBUG_MSG('start game ...')

    local game_manager = factory.create_base("GameManager")
    if not game_manager then
        ERROR_MSG("create GameManager failed !!!")
        return nil
    end

    INFO_MSG("create gamemanager ok ...")

    local ret = game_manager:register_globally()
    if not ret then
        ERROR_MSG("register GameManager global failed !!!")
        factory.destory(game_manager)
        return nil
    end

    INFO_MSG("register GameManager global ok ...")
    game_manager:on_registered()

    return 0
end

return _M
