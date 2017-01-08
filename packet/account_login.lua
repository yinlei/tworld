-------------------------------------------------------------------------------
-- account_login.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local ser = require "lib.ser"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local opcode = require(_PACKAGE .. "/opcode")

local _M = {
    ID = opcode.ACCOUNT_LOGIN,

    C_DATA = {
        -- 版本
        version  = 0,
        -- 用户名
        username = "",
    },

    S_DATA = {
        -- code
        result = 0,
        key = "",
        address = "",
    }
}

function _M.c_encode(...)
    local args = {...}
    assert(#args == 2, "error packet")
    ser:begin_write()
    ser:write_int32(args[1])
    ser:write_string(args[2])
    return ser:over_write()
end

function _M.s_encode(...)
    local args = {...}
    assert(#args == 3, "error packet")
    tengine.p(args)
    ser:begin_write()
    ser:write_int32(args[1])
    ser:write_string(args[2])
    ser:write_string(args[3])
    return ser:over_write()
end

function _M.c_decode(bytes, size)
    ser:begin(bytes, size)
    _M.S_DATA.result = ser:read_uint32()
    _M.S_DATA.key = ser:read_string()
    _M.S_DATA.address = ser:read_string()
    ser:over()
    return _M.S_DATA
end

function _M.s_decode(bytes, size)
    ser:begin(bytes, size)
    _M.C_DATA.version = ser:read_int32()
    _M.C_DATA.username = ser:read_string()
    ser:over()
    return _M.C_DATA
end

return _M
