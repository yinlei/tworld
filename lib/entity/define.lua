--------------------------------------------------------------------------------
-- define.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local cjson = tengine.cjson

local flags = require(_PACKAGE .. "/flag")
local types = require(_PACKAGE .. "/type")

local _M = {}

local name_defines = {}
local type_defines = {}
local models = {}

local function _parser(t)
	local d = require ("data.entity." ..t)
	if not d then
        error("parser entity failed !!!")
		return
	end

	if d.MMap then
		d.cached = 1
	end

	d.PropertyNames = {}
    d.PropertyIndexs = {}

	for k, value in ipairs(d.Properties) do

		if value.Name then
            value.Index = k

			d.PropertyNames[value.Name] = value

            d.PropertyIndexs[k] = value

			if value.UniqueIndex then
				d.UniqueIndex = value.Name
			end

			local flag = 0

            if type(value.Flags) ~= 'table' then
                error("flag type is error " .. value.Name .. " " .. value.Flags)
            end

            for _, v in pairs(value.Flags) do
                if v == "CLIENT" then
                    flag = flags.set_client(flag)
                elseif v == "BASE" then
                    flag = flags.set_base(flag)
                elseif v == "CELL" then
                    flag = flags.set_cell(flag)
                elseif v == "OTHER" then
                    flag = flags.set_other_clients(flag)
                else
                    error("unknown type " .. v)
                end
            end

			value.Flags = flag
		end
	end

    local attributes = {}
    local indices = {}
    local uniques = {}
    local tracked = {}

	for _, value in pairs(d.Properties) do
		if value.Persistent then
            attributes[#attributes+1] = value.Name
		end

        if value.UniqueIndex then
            uniques[#uniques+1] = value.Name
        end

	end

    d.model = {attributes = attributes, indices = indices, uniques = uniques, tracked = tracked}

	return d
end

function _M.get(key)
	if type(key) == "string" then
		if not name_defines[key] then
			local _define = _parser(key)
			name_defines[key] = _define
			return _define
		end

		return name_defines[key]
	elseif type(key) == "number" then
		local name = types.name(key)
		return _M.get(name)
	end

	return nil
end

return _M
