--------------------------------------------------------------------------------
-- 技能系统
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local SkillSystem = require(_PACKAGE.."/system")

require (_PACKAGE.."/data")
require (_PACKAGE.."/check")
require (_PACKAGE.."/buff")
require (_PACKAGE.."/learn")
require (_PACKAGE.."/cast")
require (_PACKAGE.."/use")

return SkillSystem
