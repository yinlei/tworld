-------------------------------------------------------------------------------
-- client_login.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local actor = tengine.actor
local ser = require "lib.ser"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local opcode = require(_PACKAGE .. "/opcode")

local _M = {
    ID = opcode.CLIENT_LOGIN,

    C_DATA = {
        -- 登录密匙
        key  = 0,
    },

    S_DATA = {
        -- code
        result = 0,
    }
}

function _M.c_encode(key)
    ser:begin_write()
    ser:write_uint32(key)
    return ser:over_write()
end

function _M.s_encode(...)
    local args = {...}
    assert(#args == 1, "error packet")
    ser:begin_write()
    ser:write_int32(args[1])
    return ser:over_write()
end

function _M.c_decode(bytes, size)
    ser:begin(bytes, size)
    _M.S_DATA.result = ser:read_uint32()
    ser:over()
    return _M.S_DATA
end

function _M.s_decode(bytes, size)
    ser:begin(bytes, size)
    _M.C_DATA.key = ser:read_uint32()
    ser:over()
    return _M.C_DATA
end


return _M
