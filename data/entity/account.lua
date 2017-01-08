--------------------------------------------------------------------------------
-- Account
--------------------------------------------------------------------------------

return
{
    Name = "account",

    MMap = {
        file = "account.mmap",
        capacity = 2084,
        flush = {
            modify = 600,
            delete = 5,
            checkout = 5,
        }
    },

    Properties = {
        {
            Name = "name",
            Type = "STRING",
            Flags = {"CLIENT", "BASE"},
            Persistent = true,
            UniqueIndex = true
        },
        {
            Name = "plat_account",
            Type = "STRING",
            Flags = {"BASE"},
            Persistent = true
        },
        {
            Name = "create_time",
            Type = "UINT32",
            Flags = {"BASE"},
            Persistent = true
        },
        {
            Name = "active_avatar_id",
            Type = "UINT32",
            Flags = {"BASE"},
        },

        {
            Name = "avatar_quit_flag",
            Type = "UINT8",
            Flags = {"BASE"},
            Default = 0,
        },

        {
            Name = "avatars",
            Type = "LUA_TABLE",
            Flags = {"CLIENT", "BASE"},
            Persistent = true,
        },

        {
            Name = "login_service",
            Type = "UINT32",
            Flags = {"BASE"},
        }
    }
}
