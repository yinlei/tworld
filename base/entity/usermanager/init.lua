--------------------------------------------------------------------------------
-- usermanager
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local _M = require(_PACKAGE.."/usermanager")
require (_PACKAGE.."/startup")
require (_PACKAGE.."/name")
require (_PACKAGE.."/query")
require (_PACKAGE.."/rank")
require (_PACKAGE.."/chat")

return _M
