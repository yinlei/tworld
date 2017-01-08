--------------------------------------------------------------------------------
-- space.lua
--------------------------------------------------------------------------------
--local aoi = require "framework.lib.aoi"
local map = tengine.map

local ERROR_MSG = tengine.ERROR_MSG
local INFO_MSG = tengine.INFO_MSG
local p = tengine.p

local spaces = {}

local function get_id(self)
	return self.id
end

local function add_entity(self, entity, pos)
	if not entity then
        return false
	end

    local id = entity:get_id()

    if not self.objects:insert(id, entity) then
        ERROR_MSG("Space add_entity objects insert failed !!!")
        return
    end

	entity:set_space_id(self.id)

    entity:set_xy(pos.x, pos.y)

    self.aoi:enter(id, pos)

    INFO_MSG("Space add_entity ok id(%d)!!!", id)

    return true
end

local function delete_entity(self, entity)
    if not entity then
        return false
    end
    local id = entity:get_id()

    self.objects:erase(id)

    --self.aoi:leave(id)

    return true
end

local function get_entity(self, id)
    return self.objects[id]
end

local methods = {
    get_id = get_id,
    add_entity = add_entity,
    delete_entity = delete_entity,
    get_entity = get_entity,
}

local new = function(id)
    local self = setmetatable({}, {__index = methods})
	self.id = id
    self.objects = map:new()
    --self.aoi = aoi:new(120, 120, 2, 100000)

	spaces[id] = self

    return self
end

local find = function(id)
    return spaces[id]
end

return {
    new = new,
    find = find,
}
