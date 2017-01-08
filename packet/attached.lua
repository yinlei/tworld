-------------------------------------------------------------------------------
-- attached.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local ser = require "lib.ser"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local opcode = require(_PACKAGE .. "/opcode")

local _M = {
    ID = opcode.ATTACHED,

    C_DATA = {
    },

    S_DATA = {
        key = "",
        entity = {},
    }
}

function _M.c_encode(...)
    assert(false)
end

function _M.s_encode(...)
    local args = {...}
    assert(#args == 2, "error packet")
    ser:begin_write()
    ser:write_string(args[1])
    ser:write_table(args[2])
    return ser:over_write()
end

function _M.c_decode(bytes, size)
    ser:begin(bytes, size)
    _M.S_DATA.key = ser:read_string()
    _M.S_DATA.entity = ser:read_table()
    ser:over()
    return _M.S_DATA
end

function _M.s_decode(bytes, size)
    assert(false)
end

return _M
