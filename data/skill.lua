--------------------------------------------------------------------------------
-- 技能配置
--------------------------------------------------------------------------------

return {
    -- 技能1
    [1001] = {
        name = "1001",
        desc = "技能",
        pos = 0,
        level = 1,
        weapon = 1,
        limit_level = 1,
        vocation = 1,
        next_skill = 1002,
        -- 1.技能cd 2.
        cd = {1000, 0, 1200, 400},
        cast_time = 0,
        cast_range = 400,
        action = {1001},
    },

    [1002] = {
        name = "1002",
        desc = "技能",
        pos = 0,
        level = 2,
        weapon = 1,
        limit_level = 1,
        vocation = 1,
        next_skill = 1002,
        cd = {1000, 0, 1200, 400},
        cast_time = 0,
        cast_range = 400,
        action = {1001},
    },

    [1003] = {
        name = "1003",
        desc = "技能",
        pos = 0,
        level = 3,
        weapon = 1,
        limit_level = 1,
        vocation = 1,
        next_skill = 1002,
        cd = {1000, 0, 1200, 400},
        cast_time = 0,
        cast_range = 400,
        action = {1002},
    },

    [1004] = {
        name = "1004",
        desc = "技能",
        pos = 0,
        level = 4,
        weapon = 1,
        limit_level = 1,
        vocation = 1,
        next_skill = 0,
        cd = {1000, 0, 1200, 400},
        cast_time = 0,
        cast_range = 400,
        action = {1004},
    },
}

