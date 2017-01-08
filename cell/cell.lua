--------------------------------------------------------------------------------
-- cell.lua
--------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local manager = require ("lib.entity").manager
local rpc = require ("lib.entity").rpc

local space = require "cell.space"

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local _M = {}

function _M.init(conf)

end

function _M.create_cell_in_new_space(type, s, attrs)
    p("create_cell_in_new_space")
    local sp = space.create()
    if not sp then
        ERROR_MSG("create new space failed !!!")
        return
    end

    local entity = manager.create(type, s.id)
    if not entity then
        ERROR_MSG("create entity failed !!!")
        return
    end

    entity:set_space_id(sp:get_id())

    entity:set_base(rpc(s))

    entity:init()

    local id = s.service
    s.service = actor.self()

    -- local object = actor.async(id)
    -- object.on_get_cell(s)
    return s
end

function _M.create_cell_via_mycell(id, s, x, y, mask, attrs)
    p("create_cell_via_mycell", id, s, x, y, mask, attrs)
    local sp_entity = manager.entity(id)

    local sp

    if sp_entity then
        local sp_id = sp_entity:get_space_id()

        sp = space.find(sp_id)
    end

    if not sp then
        ERROR_MSG("cann't find space !!!")
        return
    end

    local entity = manager.create(s.name, s.id, attrs)

    if not entity then
        ERROR_MSG("create entity " .. s.name .. " failed !!!")
        return
    end

    entity:init()

    sp:add_entity(entity, {x = x, y = y})

    local base = rpc(s)
    entity:set_base(base)

    p("on_get_cell start", s)
    local object = actor.async(s.service)
    object.on_get_cell(entity.service)
    p("on_get_cell end")
    entity:on_enter_space()
end

return _M
