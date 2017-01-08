#ifdef __cplusplus
extern "C" {
#endif

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#include "aes.h"

#ifdef __cplusplus
}
#endif


static char *key = {0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x0};

static int
_encrypt(lua_State *L) {
    char *in = luaL_checkstring(L, 1);


    return 1;
}

static int
_decrypt(lua_State *L) {

    return 1;
}

int
luaopen_aes128(lua_State* L) {
    luaL_Reg reg[] = {
        {"encrypt", _encrypt},
        {"decrypt", _decrypt},
        {NULL, NULL},
    };

    luaL_checkversion(L);
    luaL_newlib(L, reg);
}

