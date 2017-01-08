--------------------------------------------------------------------------------
-- space
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local space = require (_PACKAGE .. "/space")

local spaceloader = require (_PACKAGE .. "/spaceloader")

local space_id = 0

local idle_spaces = {}

local create = function()
    local id = space_id + 1

    local sp = space.new(id)

    idle_spaces[id] = sp

    space_id = id

    return sp
end

local idle = function(id)
    return idle_spaces[id]
end

return {
    create = create,
    idle = idle,
    find = space.find,

    spaceloader = spaceloader,
}
