--------------------------------------------------------------------------------
-- 代理服务器
-- 负责玩家连接协议解析
--------------------------------------------------------------------------------
local T = require "tengine"

local timer = T.timer

require "base.entity"
require "base.core"

local conf = require "config"

local function main(...)
    local function gc()
        collectgarbage()
        collectgarbage()
        timer.callback(100, gc)
    end

    timer.callback(100, gc)

   require "base"(...)
end

T.start(main, conf)
