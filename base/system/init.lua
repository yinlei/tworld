-------------------------------------------------------------------------------
-- system
-------------------------------------------------------------------------------

local _PACKAGE = string.gsub(...,"%.","/") or ""


return {
	Inventory = require(_PACKAGE.."/inventory"),
    Activity = require (_PACKAGE.."/activity"),
    Friend = require (_PACKAGE.."/friend"),
    Task = require (_PACKAGE.."task"),

}
