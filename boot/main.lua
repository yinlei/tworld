--------------------------------------------------------------------------------
-- main.lua
--------------------------------------------------------------------------------
local T = require "tengine"

local actor = T.actor

local logo = [[
   .___________.____    __    ____  ______   .______       __       _______
   |           |\   \  /  \  /   / /  __  \  |   _  \     |  |     |       \
   `---|  |----` \   \/    \/   / |  |  |  | |  |_)  |    |  |     |  .--.  |
       |  |       \            /  |  |  |  | |      /     |  |     |  |  |  |
       |  |        \    /\    /   |  `--'  | |  |\  \----.|  `----.|  '--'  |   tengine version: %s
       |__|         \__/  \__/     \______/  | _| `._____||_______||_______/    tengine version: %s                                                                
]]

print(string.format(logo, T._VERSION, T._VERSION) )

T.start(
    function()
        -- 启动存储服务
        actor.newservice("store")

        -- 启动全局服务
        actor.newservice("global")

        -- 启动代理服务
        actor.newservice("base")
        --actor.newservice("base")
        --actor.newservice("base")

        -- 启动场景服务器
        actor.newservice("cell")

        -- 启动登录服务
        actor.newservice("login")
   end
)
