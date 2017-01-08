-------------------------------------------------------------------------------
-- create_base_from_name.lua
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local db = require "db"
local id = require "id"

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local  _M = {}

--- 处理命令
-- @number base base服务
-- @number flag 标记
-- @number type 实体类型
-- @string key 关键字
-- @number id 登录服务
function _M.command(base, flag, type, key, login)
    local _base = actor.sync(base)
    local _id = id.get()

    p("create_base")
    local succ, ret = _base.create_base(_id, flag, type, key, login, {})
    if not succ then
        ERROR_MSG("base create_base failed !!!")
        return
    end
    p("create_base end")
    return ret
end

return _M
