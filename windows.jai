// -----------------
// DARKMOON: WINDOWS
// -----------------

ptrdiff_t :: s64;

// Version and configuration constants
WINVER :: 0x0501;

// Lua directory configuration
LUA_LDIR :: "!\\lua\\";
LUA_CDIR :: "!\\";

// Lua environment variables
LUA_PATH :: "LUA_PATH";
LUA_CPATH :: "LUA_CPATH";
LUA_INIT :: "LUA_INIT";

// Lua path configuration
LUA_DIRSEP :: "\\";
LUA_PATHSEP :: ";";
LUA_PATH_MARK :: "?";
LUA_EXECDIR :: "!";
LUA_IGMARK :: "-";

// Lua limits and configurations
LUAI_MAXSTACK :: 65500;
LUAI_MAXCSTACK :: 8000;
LUAI_GCPAUSE :: 200;
LUAI_GCMUL :: 200;
LUA_MAXCAPTURES :: 32;
LUA_IDSIZE :: 60;

// Lua formatting
LUA_NUMBER_SCAN :: "%lf";
LUA_NUMBER_FMT :: "%.14g";
LUAI_MAXNUMBER2STR :: 32;
LUA_INTFRMLEN :: "l";

// Lua version information
LUA_VERSION :: "Lua 5.1";
LUA_RELEASE :: "Lua 5.1.4";
LUA_VERSION_NUM :: 501;
LUA_COPYRIGHT :: "Copyright (C) 1994-2008 Lua.org, PUC-Rio";
LUA_AUTHORS :: "R. Ierusalimschy, L. H. de Figueiredo & W. Celes";

// Lua signature
LUA_SIGNATURE :: "\033Lua";

// Lua return values
LUA_MULTRET :: -1;
LUA_OK :: 0;
LUA_YIELD :: 1;
LUA_ERRRUN :: 2;
LUA_ERRSYNTAX :: 3;
LUA_ERRMEM :: 4;
LUA_ERRERR :: 5;
LUA_ERRFILE :: LUA_ERRERR + 1;

// Lua types
LUA_TNONE :: -1;
LUA_TNIL :: 0;
LUA_TBOOLEAN :: 1;
LUA_TLIGHTUSERDATA :: 2;
LUA_TNUMBER :: 3;
LUA_TSTRING :: 4;
LUA_TTABLE :: 5;
LUA_TFUNCTION :: 6;
LUA_TUSERDATA :: 7;
LUA_TTHREAD :: 8;

// Lua stack
LUA_MINSTACK :: 20;

// Lua garbage collection
LUA_GCSTOP :: 0;
LUA_GCRESTART :: 1;
LUA_GCCOLLECT :: 2;
LUA_GCCOUNT :: 3;
LUA_GCCOUNTB :: 4;
LUA_GCSTEP :: 5;
LUA_GCSETPAUSE :: 6;
LUA_GCSETSTEPMUL :: 7;
LUA_GCISRUNNING :: 9;

// LuaJIT mode
LUAJIT_MODE_MASK :: 0x00ff;
LUAJIT_MODE_OFF :: 0x0000;
LUAJIT_MODE_ON :: 0x0100;
LUAJIT_MODE_FLUSH :: 0x0200;

// LuaJIT version information
LUAJIT_VERSION :: "LuaJIT 2.1.1713773202";
LUAJIT_VERSION_NUM :: 20199;
LUAJIT_COPYRIGHT :: "Copyright (C) 2005-2023 Mike Pall";
LUAJIT_URL :: "https://luajit.org/";

// LuaJIT modes
LUAJIT_MODE_ENGINE :: 0;
LUAJIT_MODE_DEBUG :: 1;
LUAJIT_MODE_FUNC :: 2;
LUAJIT_MODE_ALLFUNC :: 3;
LUAJIT_MODE_ALLSUBFUNC :: 4;
LUAJIT_MODE_TRACE :: 5;
LUAJIT_MODE_WRAPCFUNC :: 16;
LUAJIT_MODE_MAX :: 17;

// Lua hooks
LUA_HOOKCALL :: 0;
LUA_HOOKRET :: 1;
LUA_HOOKLINE :: 2;
LUA_HOOKCOUNT :: 3;
LUA_HOOKTAILRET :: 4;
LUA_MASKCALL :: 1 << LUA_HOOKCALL;
LUA_MASKRET :: 1 << LUA_HOOKRET;
LUA_MASKLINE :: 1 << LUA_HOOKLINE;
LUA_MASKCOUNT :: 1 << LUA_HOOKCOUNT;

// Lua registry indices
LUA_REGISTRYINDEX :: -10000;
LUA_ENVIRONINDEX :: -10001;
LUA_GLOBALSINDEX :: -10002;

// LuaJIT profiling callback type
luaJIT_profile_callback :: #type (data: *void, L: *lua_State, samples: s32, vmstate: s32) -> void #c_call;

// Type definitions
lua_State :: struct {};
lua_CFunction :: #type (L: *lua_State) -> s32 #c_call;
lua_Reader :: #type (L: *lua_State, ud: *void, sz: *u64) -> *u8 #c_call;
lua_Writer :: #type (L: *lua_State, p: *void, sz: u64, ud: *void) -> s32 #c_call;
lua_Alloc :: #type (ud: *void, ptr: *void, osize: u64, nsize: u64) -> *void #c_call;
lua_Number :: float64;
lua_Integer :: ptrdiff_t;
lua_Hook :: #type (L: *lua_State, ar: *lua_Debug) -> void #c_call;

lua_Debug :: struct {
    event:           s32;
    name:            *u8;
    namewhat:        *u8; /* `global', `local', `field', `method' */
    what:            *u8; /* `Lua', `C', `main', `tail' */
    source:          *u8;
    currentline:     s32;
    nups:            s32; /* number of upvalues */
    linedefined:     s32;
    lastlinedefined: s32;
    short_src:       [60] u8;
    i_ci:            s32; /* active function */
};

luaL_Reg :: struct {
    name: *u8;
    func: lua_CFunction;
};

luaL_Buffer :: struct {
    p:      *u8; /* current position in buffer */
    lvl:    s32; /* number of strings in the stack (level) */
    L:      *lua_State;
    buffer: [512] u8;
};

// Lua library names
LUA_COLIBNAME :: "coroutine";
LUA_MATHLIBNAME :: "math";
LUA_STRLIBNAME :: "string";
LUA_TABLIBNAME :: "table";
LUA_IOLIBNAME :: "io";
LUA_OSLIBNAME :: "os";
LUA_LOADLIBNAME :: "package";
LUA_DBLIBNAME :: "debug";
LUA_BITLIBNAME :: "bit";
LUA_JITLIBNAME :: "jit";
LUA_FFILIBNAME :: "ffi";

// --- FUNCTION DECLARATIONS ---
// Courtesy of @vulcan-dev!
// State manipulation
lua_newstate :: (f: lua_Alloc, ud: *void) -> *lua_State #foreign lua51;
lua_close :: (L: *lua_State) -> void #foreign lua51;
lua_newthread :: (L: *lua_State) -> *lua_State #foreign lua51;

lua_atpanic :: (L: *lua_State, panicf: lua_CFunction) -> lua_CFunction #foreign lua51;

// Basic stack manipulation
lua_gettop :: (L: *lua_State) -> s32 #foreign lua51;
lua_settop :: (L: *lua_State, idx: s32) -> void #foreign lua51;
lua_pushvalue :: (L: *lua_State, idx: s32) -> void #foreign lua51;
lua_remove :: (L: *lua_State, idx: s32) -> void #foreign lua51;
lua_insert :: (L: *lua_State, idx: s32) -> void #foreign lua51;
lua_replace :: (L: *lua_State, idx: s32) -> void #foreign lua51;
lua_checkstack :: (L: *lua_State, sz: s32) -> s32 #foreign lua51;

lua_xmove :: (from: *lua_State, to: *lua_State, n: s32) -> void #foreign lua51;

// Access functions (stack -> C)
lua_isnumber :: (L: *lua_State, idx: s32) -> s32 #foreign lua51;
lua_isstring :: (L: *lua_State, idx: s32) -> s32 #foreign lua51;
lua_iscfunction :: (L: *lua_State, idx: s32) -> s32 #foreign lua51;
lua_isuserdata :: (L: *lua_State, idx: s32) -> s32 #foreign lua51;
lua_type :: (L: *lua_State, idx: s32) -> s32 #foreign lua51;
lua_typename :: (L: *lua_State, tp: s32) -> *u8 #foreign lua51;

lua_equal :: (L: *lua_State, idx1: s32, idx2: s32) -> s32 #foreign lua51;
lua_rawequal :: (L: *lua_State, idx1: s32, idx2: s32) -> s32 #foreign lua51;
lua_lessthan :: (L: *lua_State, idx1: s32, idx2: s32) -> s32 #foreign lua51;

lua_tonumber :: (L: *lua_State, idx: s32) -> lua_Number #foreign lua51;
lua_tointeger :: (L: *lua_State, idx: s32) -> lua_Integer #foreign lua51;
lua_toboolean :: (L: *lua_State, idx: s32) -> s32 #foreign lua51;
lua_tolstring :: (L: *lua_State, idx: s32, len: *u64) -> *u8 #foreign lua51;
lua_objlen :: (L: *lua_State, idx: s32) -> u64 #foreign lua51;
lua_tocfunction :: (L: *lua_State, idx: s32) -> lua_CFunction #foreign lua51;
lua_touserdata :: (L: *lua_State, idx: s32) -> *void #foreign lua51;
lua_tothread :: (L: *lua_State, idx: s32) -> *lua_State #foreign lua51;
lua_topointer :: (L: *lua_State, idx: s32) -> *void #foreign lua51;

// Push functions (C -> stack)
lua_pushnil :: (L: *lua_State) -> void #foreign lua51;
lua_pushnumber :: (L: *lua_State, n: lua_Number) -> void #foreign lua51;
lua_pushinteger :: (L: *lua_State, n: lua_Integer) -> void #foreign lua51;
lua_pushlstring :: (L: *lua_State, s: *u8, l: u64) -> void #foreign lua51;
lua_pushstring :: (L: *lua_State, s: *u8) -> void #foreign lua51;

lua_pushfstring_CFormat :: (L: *lua_State, fmt: *u8, __args: ..Any) -> *u8 #foreign lua51 "lua_pushfstring";
lua_pushfstring :: (L: *lua_State, fmt: string, __args: ..Any) -> *u8 {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return lua_pushfstring_CFormat(L, "%s", formatted_text.data);
} @PrintLike
lua_pushcclosure :: (L: *lua_State, fn: lua_CFunction, n: s32) -> void #foreign lua51;
lua_pushboolean :: (L: *lua_State, b: s32) -> void #foreign lua51;
lua_pushlightuserdata :: (L: *lua_State, p: *void) -> void #foreign lua51;
lua_pushthread :: (L: *lua_State) -> s32 #foreign lua51;

// Get functions (Lua -> stack)
lua_gettable :: (L: *lua_State, idx: s32) -> void #foreign lua51;
lua_getfield :: (L: *lua_State, idx: s32, k: *u8) -> void #foreign lua51;
lua_rawget :: (L: *lua_State, idx: s32) -> void #foreign lua51;
lua_rawgeti :: (L: *lua_State, idx: s32, n: s32) -> void #foreign lua51;
lua_createtable :: (L: *lua_State, narr: s32, nrec: s32) -> void #foreign lua51;
lua_newuserdata :: (L: *lua_State, sz: u64) -> *void #foreign lua51;
lua_getmetatable :: (L: *lua_State, objindex: s32) -> s32 #foreign lua51;
lua_getfenv :: (L: *lua_State, idx: s32) -> void #foreign lua51;

// Set functions (stack -> Lua)
lua_settable :: (L: *lua_State, idx: s32) -> void #foreign lua51;
lua_setfield :: (L: *lua_State, idx: s32, k: *u8) -> void #foreign lua51;
lua_rawset :: (L: *lua_State, idx: s32) -> void #foreign lua51;
lua_rawseti :: (L: *lua_State, idx: s32, n: s32) -> void #foreign lua51;
lua_setmetatable :: (L: *lua_State, objindex: s32) -> s32 #foreign lua51;
lua_setfenv :: (L: *lua_State, idx: s32) -> s32 #foreign lua51;

// `load' and `call' functions (load and run Lua code)
lua_call :: (L: *lua_State, nargs: s32, nresults: s32) -> void #foreign lua51;
lua_pcall :: (L: *lua_State, nargs: s32, nresults: s32, errfunc: s32) -> s32 #foreign lua51;
lua_cpcall :: (L: *lua_State, func: lua_CFunction, ud: *void) -> s32 #foreign lua51;
lua_load :: (L: *lua_State, reader: lua_Reader, dt: *void, chunkname: *u8) -> s32 #foreign lua51;

lua_dump :: (L: *lua_State, writer: lua_Writer, data: *void) -> s32 #foreign lua51;

// Coroutine functions
lua_yield :: (L: *lua_State, nresults: s32) -> s32 #foreign lua51;
lua_resume :: (L: *lua_State, narg: s32) -> s32 #foreign lua51;
lua_status :: (L: *lua_State) -> s32 #foreign lua51;

lua_gc :: (L: *lua_State, what: s32, data: s32) -> s32 #foreign lua51;

// Miscellaneous functions
lua_error :: (L: *lua_State) -> s32 #foreign lua51;

lua_next :: (L: *lua_State, idx: s32) -> s32 #foreign lua51;

lua_concat :: (L: *lua_State, n: s32) -> void #foreign lua51;

lua_getallocf :: (L: *lua_State, ud: **void) -> lua_Alloc #foreign lua51;
lua_setallocf :: (L: *lua_State, f: lua_Alloc, ud: *void) -> void #foreign lua51;

lua_getstack :: (L: *lua_State, level: s32, ar: *lua_Debug) -> s32 #foreign lua51;
lua_getinfo :: (L: *lua_State, what: *u8, ar: *lua_Debug) -> s32 #foreign lua51;
lua_getlocal :: (L: *lua_State, ar: *lua_Debug, n: s32) -> *u8 #foreign lua51;
lua_setlocal :: (L: *lua_State, ar: *lua_Debug, n: s32) -> *u8 #foreign lua51;
lua_getupvalue :: (L: *lua_State, funcindex: s32, n: s32) -> *u8 #foreign lua51;
lua_setupvalue :: (L: *lua_State, funcindex: s32, n: s32) -> *u8 #foreign lua51;
lua_sethook :: (L: *lua_State, func: lua_Hook, mask: s32, count: s32) -> s32 #foreign lua51;
lua_gethook :: (L: *lua_State) -> lua_Hook #foreign lua51;
lua_gethookmask :: (L: *lua_State) -> s32 #foreign lua51;
lua_gethookcount :: (L: *lua_State) -> s32 #foreign lua51;

/* From Lua 5.2. */
lua_upvalueid :: (L: *lua_State, idx: s32, n: s32) -> *void #foreign lua51;
lua_upvaluejoin :: (L: *lua_State, idx1: s32, n1: s32, idx2: s32, n2: s32) -> void #foreign lua51;
lua_loadx :: (L: *lua_State, reader: lua_Reader, dt: *void, chunkname: *u8, mode: *u8) -> s32 #foreign lua51;

lua_version :: (L: *lua_State) -> *lua_Number #foreign lua51;
lua_copy :: (L: *lua_State, fromidx: s32, toidx: s32) -> void #foreign lua51;
lua_tonumberx :: (L: *lua_State, idx: s32, isnum: *s32) -> lua_Number #foreign lua51;
lua_tointegerx :: (L: *lua_State, idx: s32, isnum: *s32) -> lua_Integer #foreign lua51;

/* From Lua 5.3. */
lua_isyieldable :: (L: *lua_State) -> s32 #foreign lua51;

luaL_openlib :: (L: *lua_State, libname: *u8, l: *luaL_Reg, nup: s32) -> void #foreign lua51;

luaL_register :: (L: *lua_State, libname: *u8, l: *luaL_Reg) -> void #foreign lua51;

luaL_getmetafield :: (L: *lua_State, obj: s32, e: *u8) -> s32 #foreign lua51;
luaL_callmeta :: (L: *lua_State, obj: s32, e: *u8) -> s32 #foreign lua51;
luaL_typerror :: (L: *lua_State, narg: s32, tname: *u8) -> s32 #foreign lua51;
luaL_argerror :: (L: *lua_State, numarg: s32, extramsg: *u8) -> s32 #foreign lua51;
luaL_checklstring :: (L: *lua_State, numArg: s32, l: *u64) -> *u8 #foreign lua51;

luaL_optlstring :: (L: *lua_State, numArg: s32, def: *u8, l: *u64) -> *u8 #foreign lua51;

luaL_checknumber :: (L: *lua_State, numArg: s32) -> lua_Number #foreign lua51;
luaL_optnumber :: (L: *lua_State, nArg: s32, def: lua_Number) -> lua_Number #foreign lua51;

luaL_checkinteger :: (L: *lua_State, numArg: s32) -> lua_Integer #foreign lua51;
luaL_optinteger :: (L: *lua_State, nArg: s32, def: lua_Integer) -> lua_Integer #foreign lua51;

luaL_checkstack :: (L: *lua_State, sz: s32, msg: *u8) -> void #foreign lua51;
luaL_checktype :: (L: *lua_State, narg: s32, t: s32) -> void #foreign lua51;
luaL_checkany :: (L: *lua_State, narg: s32) -> void #foreign lua51;

luaL_newmetatable :: (L: *lua_State, tname: *u8) -> s32 #foreign lua51;
luaL_checkudata :: (L: *lua_State, ud: s32, tname: *u8) -> *void #foreign lua51;

luaL_where :: (L: *lua_State, lvl: s32) -> void #foreign lua51;
luaL_error_CFormat :: (L: *lua_State, fmt: *u8, __args: ..Any) -> s32 #foreign lua51 "luaL_error";
luaL_error :: (L: *lua_State, fmt: string, __args: ..Any) -> s32 {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return luaL_error_CFormat(L, "%s", formatted_text.data);
} @PrintLike

luaL_checkoption :: (L: *lua_State, narg: s32, def: *u8, lst: **u8) -> s32 #foreign lua51;

luaL_ref :: (L: *lua_State, t: s32) -> s32 #foreign lua51;
luaL_unref :: (L: *lua_State, t: s32, ref: s32) -> void #foreign lua51;

luaL_loadfile :: (L: *lua_State, filename: *u8) -> s32 #foreign lua51;
luaL_loadbuffer :: (L: *lua_State, buff: *u8, sz: u64, name: *u8) -> s32 #foreign lua51;

luaL_loadstring :: (L: *lua_State, s: *u8) -> s32 #foreign lua51;

luaL_newstate :: () -> *lua_State #foreign lua51;

luaL_gsub :: (L: *lua_State, s: *u8, p: *u8, r: *u8) -> *u8 #foreign lua51;

luaL_findtable :: (L: *lua_State, idx: s32, fname: *u8, szhint: s32) -> *u8 #foreign lua51;

/* From Lua 5.2. */
luaL_fileresult :: (L: *lua_State, stat: s32, fname: *u8) -> s32 #foreign lua51;
luaL_execresult :: (L: *lua_State, stat: s32) -> s32 #foreign lua51;
luaL_loadfilex :: (L: *lua_State, filename: *u8, mode: *u8) -> s32 #foreign lua51;

luaL_loadbufferx :: (L: *lua_State, buff: *u8, sz: u64, name: *u8, mode: *u8) -> s32 #foreign lua51;

luaL_traceback :: (L: *lua_State, L1: *lua_State, msg: *u8, level: s32) -> void #foreign lua51;

luaL_setfuncs :: (L: *lua_State, l: *luaL_Reg, nup: s32) -> void #foreign lua51;
luaL_pushmodule :: (L: *lua_State, modname: *u8, sizehint: s32) -> void #foreign lua51;

luaL_testudata :: (L: *lua_State, ud: s32, tname: *u8) -> *void #foreign lua51;
luaL_setmetatable :: (L: *lua_State, tname: *u8) -> void #foreign lua51;

// =======================================================
// Generic Buffer manipulation
// =======================================================

luaL_buffinit :: (L: *lua_State, B: *luaL_Buffer) -> void #foreign lua51;
luaL_prepbuffer :: (B: *luaL_Buffer) -> *u8 #foreign lua51;
luaL_addlstring :: (B: *luaL_Buffer, s: *u8, l: u64) -> void #foreign lua51;
luaL_addstring :: (B: *luaL_Buffer, s: *u8) -> void #foreign lua51;
luaL_addvalue :: (B: *luaL_Buffer) -> void #foreign lua51;
luaL_pushresult :: (B: *luaL_Buffer) -> void #foreign lua51;

luaopen_base :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_math :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_string :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_table :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_io :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_os :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_package :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_debug :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_bit :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_jit :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_ffi :: (L: *lua_State) -> s32 #foreign lua51;
luaopen_string_buffer :: (L: *lua_State) -> s32 #foreign lua51;

luaL_openlibs :: (L: *lua_State) -> void #foreign lua51;

#scope_file

#import "Basic"; // For assert

luajit :: #library,no_dll "luajit/bin/luajit";
lua51 :: #library,no_dll "luajit/bin/lua51";

#run {
    {
        instance: lua_Debug;
        assert(((cast(*void)(*instance.event)) - cast(*void)(*instance)) == 0, "lua_Debug.event has unexpected offset % instead of 0", ((cast(*void)(*instance.event)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.event)) == 4, "lua_Debug.event has unexpected size % instead of 4", size_of(type_of(lua_Debug.event)));
        assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 8, "lua_Debug.name has unexpected offset % instead of 8", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.name)) == 8, "lua_Debug.name has unexpected size % instead of 8", size_of(type_of(lua_Debug.name)));
        assert(((cast(*void)(*instance.namewhat)) - cast(*void)(*instance)) == 16, "lua_Debug.namewhat has unexpected offset % instead of 16", ((cast(*void)(*instance.namewhat)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.namewhat)) == 8, "lua_Debug.namewhat has unexpected size % instead of 8", size_of(type_of(lua_Debug.namewhat)));
        assert(((cast(*void)(*instance.what)) - cast(*void)(*instance)) == 24, "lua_Debug.what has unexpected offset % instead of 24", ((cast(*void)(*instance.what)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.what)) == 8, "lua_Debug.what has unexpected size % instead of 8", size_of(type_of(lua_Debug.what)));
        assert(((cast(*void)(*instance.source)) - cast(*void)(*instance)) == 32, "lua_Debug.source has unexpected offset % instead of 32", ((cast(*void)(*instance.source)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.source)) == 8, "lua_Debug.source has unexpected size % instead of 8", size_of(type_of(lua_Debug.source)));
        assert(((cast(*void)(*instance.currentline)) - cast(*void)(*instance)) == 40, "lua_Debug.currentline has unexpected offset % instead of 40", ((cast(*void)(*instance.currentline)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.currentline)) == 4, "lua_Debug.currentline has unexpected size % instead of 4", size_of(type_of(lua_Debug.currentline)));
        assert(((cast(*void)(*instance.nups)) - cast(*void)(*instance)) == 44, "lua_Debug.nups has unexpected offset % instead of 44", ((cast(*void)(*instance.nups)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.nups)) == 4, "lua_Debug.nups has unexpected size % instead of 4", size_of(type_of(lua_Debug.nups)));
        assert(((cast(*void)(*instance.linedefined)) - cast(*void)(*instance)) == 48, "lua_Debug.linedefined has unexpected offset % instead of 48", ((cast(*void)(*instance.linedefined)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.linedefined)) == 4, "lua_Debug.linedefined has unexpected size % instead of 4", size_of(type_of(lua_Debug.linedefined)));
        assert(((cast(*void)(*instance.lastlinedefined)) - cast(*void)(*instance)) == 52, "lua_Debug.lastlinedefined has unexpected offset % instead of 52", ((cast(*void)(*instance.lastlinedefined)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.lastlinedefined)) == 4, "lua_Debug.lastlinedefined has unexpected size % instead of 4", size_of(type_of(lua_Debug.lastlinedefined)));
        assert(((cast(*void)(*instance.short_src)) - cast(*void)(*instance)) == 56, "lua_Debug.short_src has unexpected offset % instead of 56", ((cast(*void)(*instance.short_src)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.short_src)) == 60, "lua_Debug.short_src has unexpected size % instead of 60", size_of(type_of(lua_Debug.short_src)));
        assert(((cast(*void)(*instance.i_ci)) - cast(*void)(*instance)) == 116, "lua_Debug.i_ci has unexpected offset % instead of 116", ((cast(*void)(*instance.i_ci)) - cast(*void)(*instance)));
        assert(size_of(type_of(lua_Debug.i_ci)) == 4, "lua_Debug.i_ci has unexpected size % instead of 4", size_of(type_of(lua_Debug.i_ci)));
        assert(size_of(lua_Debug) == 120, "lua_Debug has size % instead of 120", size_of(lua_Debug));
    }

    {
        instance: luaL_Reg;
        assert(((cast(*void)(*instance.name)) - cast(*void)(*instance)) == 0, "luaL_Reg.name has unexpected offset % instead of 0", ((cast(*void)(*instance.name)) - cast(*void)(*instance)));
        assert(size_of(type_of(luaL_Reg.name)) == 8, "luaL_Reg.name has unexpected size % instead of 8", size_of(type_of(luaL_Reg.name)));
        assert(((cast(*void)(*instance.func)) - cast(*void)(*instance)) == 8, "luaL_Reg.func has unexpected offset % instead of 8", ((cast(*void)(*instance.func)) - cast(*void)(*instance)));
        assert(size_of(type_of(luaL_Reg.func)) == 8, "luaL_Reg.func has unexpected size % instead of 8", size_of(type_of(luaL_Reg.func)));
        assert(size_of(luaL_Reg) == 16, "luaL_Reg has size % instead of 16", size_of(luaL_Reg));
    }

    {
        instance: luaL_Buffer;
        assert(((cast(*void)(*instance.p)) - cast(*void)(*instance)) == 0, "luaL_Buffer.p has unexpected offset % instead of 0", ((cast(*void)(*instance.p)) - cast(*void)(*instance)));
        assert(size_of(type_of(luaL_Buffer.p)) == 8, "luaL_Buffer.p has unexpected size % instead of 8", size_of(type_of(luaL_Buffer.p)));
        assert(((cast(*void)(*instance.lvl)) - cast(*void)(*instance)) == 8, "luaL_Buffer.lvl has unexpected offset % instead of 8", ((cast(*void)(*instance.lvl)) - cast(*void)(*instance)));
        assert(size_of(type_of(luaL_Buffer.lvl)) == 4, "luaL_Buffer.lvl has unexpected size % instead of 4", size_of(type_of(luaL_Buffer.lvl)));
        assert(((cast(*void)(*instance.L)) - cast(*void)(*instance)) == 16, "luaL_Buffer.L has unexpected offset % instead of 16", ((cast(*void)(*instance.L)) - cast(*void)(*instance)));
        assert(size_of(type_of(luaL_Buffer.L)) == 8, "luaL_Buffer.L has unexpected size % instead of 8", size_of(type_of(luaL_Buffer.L)));
        assert(((cast(*void)(*instance.buffer)) - cast(*void)(*instance)) == 24, "luaL_Buffer.buffer has unexpected offset % instead of 24", ((cast(*void)(*instance.buffer)) - cast(*void)(*instance)));
        assert(size_of(type_of(luaL_Buffer.buffer)) == 512, "luaL_Buffer.buffer has unexpected size % instead of 512", size_of(type_of(luaL_Buffer.buffer)));
        assert(size_of(luaL_Buffer) == 536, "luaL_Buffer has size % instead of 536", size_of(luaL_Buffer));
    }
}
