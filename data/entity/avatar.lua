--------------------------------------------------------------------------------
-- Avatar
--------------------------------------------------------------------------------

return
{
	Name = "avatar",

	MMap =
	{
		file = "avatar.mmap",
		capacity = 2084,
		flush = {
			modify = 600,
			delete = 5,
			chechout = 5,
		}
	},

	Properties =
	{
		{
			Name 		= "vocation",
			Type 		= "UINT8",
			Flags 		= {"CLIENT", "BASE", "CELL", "OTHER" },
			Persistent	= true,
		},

		{
			Name 		= "level",
			Type 		= "UINT8",
			Flags 		= {"CLIENT", "BASE", "CELL", "OTHER" },
			Persistent 	= true,
			Default 	= 1
		},

		{
			Name 		= "exp",
			Type 		= "UINT32",
			Flags 		= {"CLIENT", "BASE" },
			Persistent 	= true,
		},

		{
			Name 		= "energy",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "BASE" },
			Persistent 	= true,
		},

		{
			Name 		= "name",
			Type 		=	"STRING",
			Flags		= {"CLIENT", "BASE", "CELL", "OTHER" },
			Persistent 	= true,
		},

		{
			Name 		= "gender",
			Type		=	"UINT8",
			Flags		= {"CLIENT", "BASE", "CELL", "OTHER" },
			Persistent	= true,
		},

        {
			Name 		= "db_id",
			Type		=	"UINT64",
			Flags		= {"BASE", "CELL" },
		},

		{
			Name 		= "create_time",
			Type		=	"UINT32",
			Flags		= {"BASE" },
			Persistent	= true,
		},

		{
			Name 		= "account_name",
			Type		=	"STRING",
			Flags		= {"BASE" },
			Persistent	= true
		},

		{
			Name 		= "account_id",
			Type		=	"UINT32",
			Flags		= {"BASE" },
		},

		{
			Name 		= "last_offline_time",
			Type		=	"UINT32",
			Flags		= {"BASE" },
			Persistent	= true
		},

		{
			Name 		= "scene_id",
			Type		=	"UINT32",
			Flags		= {"CLIENT", "BASE", "CELL" },
            Persistent	= true
		},

		{
			Name 		= "map_x",
			Type 		=	"UINT16",
			Flags 		= {"BASE" },
			Persistent = true
		},

		{
			Name 		= "map_y",
			Type 		=	"UINT16",
			Flags 		= {"BASE" },
			Persistent = true
		},

        {
			Name 		= "imap_id",
			Type 		=	"UINT16",
			Flags 		= {"CLIENT", "BASE", "CELL" },
            Persistent = true
		},

        {
			Name 		= "gold",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "BASE" },
            Default 	= 0,
            Persistent = true
		},

        {
			Name 		= "money",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "BASE" },
            Default 	= 0,
            Persistent = true
		},

        {
			Name 		= "state",
			Type 		=	"TABLE",
			Flags 		= {"BASE" },
		},

        {
            Name 		= "items",
			Type		=	"LUA_TABLE",
			Flags		= {"BASE" },
            Persistent = true
        },

        {
            Name 		= "equipments",
			Type		=	"LUA_TABLE",
			Flags    	= {"BASE"},
            Persistent = true
        },

        {
            Name 		= "skills",
			Type		=	"LUA_TABLE",
			Flags     	= {"CLIENT", "BASE", "CELL" },
            Persistent = true
        },

        {
            Name 		= "buffs",
			Type		=	"LUA_TABLE",
			Flags		= {"BASE", "CELL" },
            Persistent = true
        },

        {
            Name 		= "friends",
			Type 		=	"LUA_TABLE",
			Flags 		= {"BASE"},
            Persistent = true
        },

        -- 战斗相关属性
        -- 当前血量
        {
            Name 		= "current_hp",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL", "OTHER"},
    	},

        -- 战力
        {
            Name 		= "fight",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "OTHER"},
            Persistent  = true,
    	},

        -- 血量
        {
            Name 		= "hp",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL", "OTHER"},
    	},
        -- 攻击
        {
            Name 		= "attack",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 防御
        {
            Name 		= "defense",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 命中率
        {
            Name 		= "hit_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},

        -- 基础攻击
        {
            Name 		= "base_attack",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 基础命中率
        {
            Name 		= "base_hit_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 暴击
        {
            Name 		= "crit",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 暴击率
        {
            Name 		= "crit_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 防御减伤率
        {
            Name 		= "defense_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 抗暴击率
        {
            Name 		= "anti_crit_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 伤害减免率
        {
            Name 		= "damage_reduce_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 破击
        {
            Name 		= "strike",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 破击率
        {
            Name 		= "strike_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 抗破击
        {
            Name 		= "anti_strike",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 抗破击率
        {
            Name 		= "anti_strike_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 抗暴击
        {
            Name 		= "anti_crit",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 抗暴击率
        {
            Name 		= "anti_crit_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},
        -- 抗穿透
        {
            Name 		= "anti_defense",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL"},
    	},

        -- 抗穿透率
        {
            Name 		= "anti_defense_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},

        -- 暴击加成
        {
            Name 		= "crit_extra_attack",
			Type 		=	"UINT32",
			Flags 		= {"CLIENT", "CELL"},
    	},

        -- 闪避率
        {
            Name 		= "miss_rate",
			Type 		=	"FLOAT",
			Flags 		= {"CLIENT", "CELL"},
    	},
	}
}
