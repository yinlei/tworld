-------------------------------------------------------------------------------
-- create_cell.lua
-- base->cell
-------------------------------------------------------------------------------
local string_format = string.format

local actor = tengine.actor

local manager = require ("lib.entity").manager
local rpc = require ("lib.entity").rpc

local space = require "cell.space"
local cell =  require "cell"

local ERROR_MSG = tengine.ERROR_MSG
local p = tengine.p

local  _M = {}

function _M.create_cell_in_new_space(type, s, attrs)
    p("create_cell_in_new_space", type, s, attrs)
    return cell.create_cell_in_new_space(type, s, attrs)
end

function _M.create_cell_via_mycell(id, s, x, y, mask, attrs)
    p("create_cell_via_mycell", id, s, x, y, mask, attrs)
    return cell.create_cell_via_mycell(id, s, x, y, mask, attrs)
end

return _M
