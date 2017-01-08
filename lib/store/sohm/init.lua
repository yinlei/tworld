--------------------------------------------------------------------------------
-- sohm(https://github.com/soveran/ohm)
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local table = table

local cjson = require "cjson"
local define = require("lib/entity").define

local model = require(_PACKAGE.."/sohm").model,
local collection = require(_PACKAGE.."/collection")
local util =require(_PACKAGE .. "/util")
local auto_id = require(_PACKAGE .. "/plugins/auto_id")
local index_all = require(_PACKAGE .. "/plugins/index_all")
local index = require(_PACKAGE .. "/plugins/index")
local tostr = require(_PACKAGE .. "/plugins/tostr")

--------------------------------------------------------------------------------
local models = {}

local default_plugins = {
    ["auto_id"] = auto_id,
    ["index"] = index,
    ["index_all"] = index_all
}

local function create(name, schema)
    local _model = models[name]
    if _model then
        return _model
    end

    local _plugins = {}
    for _, value in ipairs(schema.plugins or {}) do
        table.insert(_plugins, default_plugins[value])
    end

    local _schema = {}
    _schema.attributes = attributes
    _schema.indices = indices
    _schema.plugins = _plugins

    _model = ohm.model(name, _schema, cjson)

    models[name] = _model

    return _model
end

local function entity(name)
    local _model = models[name]

    if _model then
        return _model
    end

    local d = define.get(name)

    local attributes = {}
    local serial_attributes = {}
    local counters = {}
    local indices = {}
    local lists = {}
    local sets = {}
	for _, value in pairs(d.Properties) do
		if value.Persistent and value.Type ~= "LUA_TABLE" then
            attributes[#attributes+1] = value.Name
		end

        if value.Persistent and value.Type == 'LUA_TABLE' then
            lists[#lists+1] = value.Name
        end

        if value.UniqueIndex then
            indices[#indices+1] = value.Name
        end
	end

    local schema = {}
    schema.attributes = attributes
    schema.serial_attributes = serial_attributes
    schema.counters = counters
    schema.indices = indices
    schema.lists = lists
    schema.sets = sets
    schema.plugins = {"auto_id", "index", "index_all"}

    return create(name, schema)
end

return {
    create = create,
    model = entity,
}
