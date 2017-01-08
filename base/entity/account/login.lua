-------------------------------------------------------------------------------
-- login.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local key = require("base.core").key

local server = require "server"

local _M = require (_PACKAGE.."/account")

-- key
function _M:client_key(char_id)
    local _key = key.add(self.id, char_id)
    return {_key, server.address()}
end
