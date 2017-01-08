-- 实体属性到共享内存的映射

local _M = {}

function _M.__index(t, key)
	local data = t.cache.data
	return data.key
end

function _M.__newindex(t, key, value)
	local header = t.cache.header
	local data = t.cache.data
	data.key = value
end

function _M.new(cache, owner)
	local instance = {cache = cache, owner = owner}
	setmetatable(instance, _M)
	return instance
end

return _M