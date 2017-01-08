-------------------------------------------------------------------------------
-- face.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local ERROR = tengine.ERROR_MSG

local p = tengine.p

local _M = require (_PACKAGE.."/gameentity")

function _M:set_face(face)
    self.face = face
end

function _M:get_face()
    return self.face
end
