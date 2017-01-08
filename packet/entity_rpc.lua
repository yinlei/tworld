-------------------------------------------------------------------------------
-- entity_rpc.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local ser = require "lib.ser"

local INFO_MSG = tengine.INFO_MSG
local ERROR_MSG = tengine.ERROR_MSG

local opcode = require(_PACKAGE .. "/opcode")

local _M = {
    ID = opcode.ENTITY_RPC,

    DATA = {
        -- rpc
        name = "",
        -- 参数
        args = {},
    }
    -- C_DATA = {
    --     -- 方法
    --     name  = 0,
    --     -- 参数
    --     args = {},
    -- },

    -- S_DATA = {
    --     -- 方法
    --     name = "",
    --     -- 参数
    --     args = {},
    -- }
}

function _M.c_encode(...)
    local args = {...}
    assert(#args == 2, "error packet")
    ser:begin_write()
    ser:write_string(args[1])
    ser:write_table(args[2])
    return ser:over_write()
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
    _M.DATA.name = ser:read_string()
    _M.DATA.args = ser:read_table()
    ser:over()
    return _M.DATA
end

function _M.s_decode(bytes, size)
    ser:begin(bytes, size)
    _M.DATA.name = ser:read_string()
    _M.DATA.args = ser:read_table()
    ser:over()
    return _M.DATA
end

return _M
