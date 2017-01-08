-------------------------------------------------------------------------------
-- core
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local actor = tengine.actor

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

return {
	client = require(_PACKAGE .. "/client"),
	factory = require(_PACKAGE .. "/factory"),
	global = require(_PACKAGE .. "/global"),
	--rpc = require(_PACKAGE .. "/rpc"),
	key = require(_PACKAGE .. "/key"),
}
