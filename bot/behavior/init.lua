-------------------------------------------------------------------------------
-- 行为树
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local bt = tengine.behaviourtree

bt.register("account_login", require(_PACKAGE.."/account_login"))
bt.register("client_login", require(_PACKAGE.."/client_login"))

local function new()
    return bt:new({
        tree = bt.Sequence:new({nodes = {"account_login", "client_login"}})
    })
end

return {
    new = new
}
