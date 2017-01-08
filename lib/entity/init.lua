--------------------------------------------------------------------------------
-- entity
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

return {
    entity = require(_PACKAGE.."/entity"),
	flag = require(_PACKAGE.."/flag"),
	type = require(_PACKAGE.."/type"),
	define = require(_PACKAGE.."/define"),
	manager = require(_PACKAGE.."/manager"),
    rpc = require(_PACKAGE.."/rpc"),
}
