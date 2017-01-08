-------------------------------------------------------------------------------
-- chat.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local RpcWrap = require("lib.entity").rpc

local _M = require(_PACKAGE.."/usermanager")

function _M:chat()

end
