--------------------------------------------------------------------------------
-- spaceloader.lua
--------------------------------------------------------------------------------
local _M = {}

local space_loaders = {}

local space_loader_player_counts = {}

function _M.register(sp)
    local id = sp:get_space_id()

    space_loaders[id] = sp

    space_loader_player_counts[id] = 0
end

function _M.find(id)
    return space_loaders[id]
end

return _M
