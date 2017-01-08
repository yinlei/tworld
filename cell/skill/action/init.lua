--------------------------------------------------------------------------------
-- action
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local SkillAction = require(_PACKAGE.."/action")

require (_PACKAGE.."/data")
--require (_PACKAGE.."/learn")
--require (_PACKAGE.."/use")

return SkillAction
