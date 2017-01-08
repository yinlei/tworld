--------------------------------------------------------------------------------
-- db.lua
--------------------------------------------------------------------------------
local string_format = string.format

local c = tengine.c
local redis = tengine.redis

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

-------------------------------------------------------------------------------
local _M = {}

local db

function _M.init(conf)
    db = redis.new(conf.redis or 'redis')

    if not db then
        ERROR_MSG("create db failed !!!")
    end
end

function _M.driver()
    return db
end

return _M
