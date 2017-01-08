-------------------------------------------------------------------------------
-- account
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local _M = require(_PACKAGE.."/account")
require (_PACKAGE.."/login")
require (_PACKAGE.."/const")
require (_PACKAGE.."/avatar")
require (_PACKAGE.."/character")
require (_PACKAGE.."/game")
require (_PACKAGE.."/version")
require (_PACKAGE.."/helper")

return _M
