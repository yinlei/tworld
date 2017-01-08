--------------------------------------------------------------------------------
-- gameentity
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local _M = require(_PACKAGE.."/gameentity")
require (_PACKAGE.."/face")
require (_PACKAGE.."/speed")
require (_PACKAGE.."/move")
require (_PACKAGE.."/visiable")
require (_PACKAGE.."/teleport")
require (_PACKAGE.."/space")
require (_PACKAGE.."/pack")
require (_PACKAGE.."/sync")

return _M
