-------------------------------------------------------------------------------
-- baseentity
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local _M = require(_PACKAGE.."/baseentity")
require (_PACKAGE.."/client")
require (_PACKAGE.."/cell")
require (_PACKAGE.."/sync")
require (_PACKAGE.."/pack")

return _M
