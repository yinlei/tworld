-------------------------------------------------------------------------------
-- 行为树
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local bt = tengine.behaviourtree

bt.register("login", require(_PACKAGE.."/login"))
bt.register("game", require(_PACKAGE.."/game"))

local function new()
    return bt:new({
        tree = bt.Sequence:new({nodes = {"login", "game"}})
    })
end

return {
    new = new
}
