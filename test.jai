print_luajit_version :: () {

    // (1) Initialize the Lua state
    state : *lua_State;
    state = luaL_newstate();
    if (state == null) {
        print("Failed to create Lua state :(\n");
        return;
    }

    // (2) Open Lua libraries
    luaL_openlibs(state);

    // (3) Load the LuaJIT version check
    version_script : *u8 = "print(jit.version)";
    load_status := luaL_loadstring(state, version_script);
    if (load_status != LUA_OK) {
        lua_close(state);
        return;
    }

    // (4) Execute Lua chunk
    call_status := lua_pcall(state, 0, LUA_MULTRET, 0);

    // (5) Close the Lua state
    lua_close(state);
}

main :: () {
    print_luajit_version();
}

#import "Basic";

// #import "Darkmoon";
#load "module.jai";
