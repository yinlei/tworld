--------------------------------------------------------------------------------
-- main.lua
--------------------------------------------------------------------------------
local T = require "tengine"

local config = require "config"
local bot = require "bot"

T.start(
    function()
        for i = 1, config.maxcount do
            local b = bot.new("test" .. tostring(i))
            if b then
                b:start(config.address, config.version)
            end
        end
    end
)
