-------------------------------------------------------------------------------
-- store->base
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local define = require("lib.entity").define
local manager = require("lib.entity").manager
local store = require("lib.store")

local factory = require("base.core.factory")

local db = require "db"

-------------------------------------------------------------------------------
local  _M = {}

function _M.command(id, flag, type, key, login, args)
    p(id, flag, type, key, login, args)

    args = args or {}

    local _define = define.get(type)
    if not _define then
        ERROR_MSG("cann't find define %s", type)
        return
    end

    local model = store.model(type)
    if not model then
        ERROR_MSG("cann't get %s model !!!", type)
        return
    end

    local data = model:with(db.driver(), _define.UniqueIndex, key)

    -- p("model with ", key, data)

    local _entity
    if not data then
        data = {}
        if _define.UniqueIndex then
            data[_define.UniqueIndex] = key
        end
        _entity = factory.create_base_with_data(type, id, data, db.driver(), model)
    else
        local db_id = data.id
        data.id = nil
        _entity = factory.create_base_from_db_data(type, id, db_id, data, db.driver(), model)
    end

    if not _entity then
        ERROR_MSG("factory create_base_with_data failed !!!")
        return
    end

    return _entity.service
end

return _M
