-------------------------------------------------------------------------------
-- inventory
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local InventorySystem = require(_PACKAGE.."/inventory")
require (_PACKAGE.."/id")
require (_PACKAGE.."/operation")
require (_PACKAGE.."/new")
require (_PACKAGE.."/check")
require (_PACKAGE.."/avatar")
require (_PACKAGE.."/equipment")
require (_PACKAGE.."/update")
require (_PACKAGE.."/sync")
require (_PACKAGE.."/add")
--require (_PACKAGE.."/version")
--require (_PACKAGE.."/misc")
-- TODO

return InventorySystem
