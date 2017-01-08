-------------------------------------------------------------------------------
-- gm.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local string_len = string.len
local string_byte = string.byte
local string_sub = string.sub

local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local GMSystem = require "base.system.gm"

local _M = require (_PACKAGE.."/avatar")

function _M:execute(cmd)
    -- 转到GM系统
    local args = {"Avatar", self}

    return GMSystem:execute(self.account_name, cmd, args)
end
