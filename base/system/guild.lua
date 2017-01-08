-------------------------------------------------------------------------------
-- guild.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR = tengine.ERROR_MSG
local INFO = tengine.INFO_MSG
local DEBUG = tengine.DEBUG_MSG
local p = tengine.p

local class = require "lib.middleclass"

local global = require("base.core").global

local System = require(_PACKAGE.."/system")

local GuildSystem = class("FriendSystem", System)

function GuildSystem:initialize(owner)
    System.initialize(self, owner)
end

return GuildSystem
