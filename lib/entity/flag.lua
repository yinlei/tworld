--------------------------------------------------------------------------------
-- flag.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local bit = tengine.bit

local lshift, bor, band = bit.lshift, bit.bor, bit.band

local _M = {}

_M.BASE = lshift(1, 0)
_M.CELL = lshift(1, 1)
_M.CLIENT = lshift(1, 2)
_M.OTHERCLIENTS = lshift(1, 4)

function _M.set_base(e)
    e = bor(e, _M.BASE)
	return e
end

function _M.set_cell(e)
	e = bor(e, _M.CELL)
	return e
end

function _M.set_client(e)
	e = bor(e ,_M.CLIENT)
	return e
end

function _M.set_other_clients(e)
	e = bor(e ,_M.OTHERCLIENTS)
	return e
end

function _M.is_base(e)
	return band(e, _M.BASE) > 0
end

function _M.is_cell(e)
	return band(e, _M.CELL) > 0
end

function _M.is_client(e)
	return band(e, _M.CLIENT) > 0
end

function _M.is_other_clients(e)
	return band(e, _M.OTHERCLIENTS) > 0
end

function _M.is_baseandclient(e)
	return _M.is_base(e) and _M.is_client(e)
end

function _M.is_cellandclient(e)
	return _M.is_cell(e) and _M.is_client(e)
end

return _M
