--------------------------------------------------------------------------------
-- avatar
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local _M = require(_PACKAGE.."/avatar")

require (_PACKAGE.."/property")
require (_PACKAGE.."/login")
require (_PACKAGE.."/space")
--require (_PACKAGE.."/move")
--require (_PACKAGE.."/teleport")
require (_PACKAGE.."/skill")
require (_PACKAGE.."/pick")
require (_PACKAGE.."/revive")

return _M
