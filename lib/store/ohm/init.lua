--------------------------------------------------------------------------------
-- sohm(https://github.com/soveran/ohm)
--------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local table = table

local cjson = require "cjson"
local define = require("lib/entity").define

local ohm = require(_PACKAGE.."/model")
--------------------------------------------------------------------------------
local models = {}

local function model(name)
    if not models[name] then
        local d = define.get(name)
        if not d then
            return nil
        end
        models[name] = ohm.model(name, d.model)
    end

    return models[name]
end


return {
    model = model
}

