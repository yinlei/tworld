-------------------------------------------------------------------------------
-- scene.lua
-------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local INFO_MSG = tengine.INFO_MSG
local DEBUG_MSG = tengine.DEBUG_MSG
local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local RpcWrap = require("lib.entity").rpc

local Global = require("lib.entity").global

local EntityManager = require("lib.entity").manager

local _M = require (_PACKAGE.."/avatar")

function _M:change_scene(scene, line, x, y)
	p("Avatar change_scene", scene, line, x, y)

	p(self.cell)

	if self.cell then
		p("Avatar change_scene")
		self.scene_id = scene
		self.imap_id = line
		self.map_x = x
		self.map_y = y

		self.client.ChangeScene(scene)
	end
end
