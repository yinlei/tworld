--------------------------------------------------------------------------------
-- db.lua
--------------------------------------------------------------------------------
local string_format = string.format

local redis = tengine.redis

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local store = require "lib.store"

local _M = {}

local db

function _M.init(conf)
    db = redis.new(conf.redis or 'redis')

    if not db then
        ERROR_MSG("db init failed !!!")
    end
end

function _M.driver()
    return db
end

--[[
function _M.check_account(name)
    if not db then
        ERROR_MSG("db is invalid !!!")
        return 3
    end

    -- 检查账号
    local a = account:with(db, "account", name)

    if not a then
        -- 创建
        local temp = {
            name = name,
            email = "",
        }

        local id = account:save(db, temp)
    end

    return 0
end
--]]

return _M
