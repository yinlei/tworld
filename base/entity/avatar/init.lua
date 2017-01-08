--------------------------------------------------------------------------------
-- avatar
--------------------------------------------------------------------------------

local _PACKAGE = string.gsub(...,"%.","/") or ""

local _M = require(_PACKAGE.."/avatar")
require (_PACKAGE.."/property")
require (_PACKAGE.."/client")
require (_PACKAGE.."/destory")
require (_PACKAGE.."/login")
require (_PACKAGE.."/time")
require (_PACKAGE.."/chat")
require (_PACKAGE.."/gm")
require (_PACKAGE.."/mail")
require (_PACKAGE.."/map")
require (_PACKAGE.."/move")
require (_PACKAGE.."/friend")
require (_PACKAGE.."/teleport")
require (_PACKAGE.."/energy")
require (_PACKAGE.."/skill")
require (_PACKAGE.."/scene")
require (_PACKAGE.."/cell")
require (_PACKAGE.."/item")
-- 信息提示接口
require (_PACKAGE.."/tip")
-- TODO

return _M
