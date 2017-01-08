---------------------------------------------------------------------------------
-- entity
---------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

local account = require(_PACKAGE.."/account")
local avatar = require(_PACKAGE.."/avatar")
local gamemanager = require(_PACKAGE.."/gamemanager")
local mapmanager = require(_PACKAGE.."/mapmanager")
local offlinemanager = require(_PACKAGE.."/offlinemanager")
local usermanager = require(_PACKAGE.."/usermanager")
local spaceloader = require(_PACKAGE.."/spaceloader")

local manager = require("lib.entity").manager

manager.register("Account", account)
manager.register("Avatar", avatar)
manager.register("GameManager", gamemanager)
manager.register("MapManager", mapmanager)
manager.register("OfflineManager", offlinemanager)
manager.register("UserManager", usermanager)
manager.register("SpaceLoader", spaceloader)

return {
    account = account,
    avatar = avatar,
    gamemanager = gamemanager,
    mapmanager = mapmanager,
    offlinemanager = offlinemanager,
    usermanager = usermanager,
    spaceloader = spaceloader,
}
