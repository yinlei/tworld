-------------------------------------------------------------------------------
-- key.lua
-------------------------------------------------------------------------------
local md5 = tengine.md5

local keys = {}

local key_index = 0

local _M = {}

local function _key(account, id)
    key_index = key_index + 1
	return key_index
end

function _M.add(account, id)
	local key = _key(account, id)
	keys[key] = {key, id, os.time(), account}

	return key
end

function _M.get(key)
	return keys[key]
end

function _M.remove(key)
	keys[key] = nil
end

return _M
