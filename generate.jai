// This script generates a windows.jai into the 'gen' directory, and requires the luajit source files!
// The windows.jai in the root directory has been hand-edited.

AT_COMPILE_TIME :: true;

LUAJIT_PATH :: "luajit";

// DECLARATIONS_TO_OMIT :: string.[
// ];

#if AT_COMPILE_TIME {
    #run,stallable {
        make_directory_if_it_does_not_exist("gen");
        set_build_options_dc(.{do_output=false});
        root_options := get_build_options();
        args := root_options.compile_time_command_line;
        if !generate_bindings(args) {
            compiler_set_workspace_status(.FAILED);
        }
    }
} else {
    #import "System";

    main :: () {
        set_working_directory(path_strip_filename(get_path_of_running_executable()));
        args := get_command_line_arguments();
        if !generate_bindings(args) {
            exit(1);
        }
    }
}

generate_bindings :: (args: [] string) -> bool {
    output_filename: string;
    opts: Generate_Bindings_Options;
    {
        using opts;

        // TODO: platform support!
        #if OS == .WINDOWS {
            // array_add(*libpaths, tprint("%/bin/windows", LUAJIT_PATH));
            output_filename = "gen/windows.jai";
        } else {
            #if OS == .LINUX {
                // array_add(*libpaths, tprint("%/bin/linux", LUAJIT_PATH));
            } else #if OS == .MACOS {
                // array_add(*libpaths, tprint("%/bin/macos", LUAJIT_PATH));
            } else {
                assert(false);
            }
            output_filename = "gen/unix.jai";
            generate_library_declarations = false;
            footer = FOOTER_UNIX;
        }

        array_add(*libpaths, tprint("%/bin", LUAJIT_PATH));

        array_add(*libnames, "luajit");
        array_add(*libnames, "lua51");

        // Regenerating the bindings requires cloning and compiling the LuaJIT repo.
        array_add(*source_files, tprint("%/src/lua.h", LUAJIT_PATH));
        array_add(*source_files, tprint("%/src/lualib.h", LUAJIT_PATH));
        array_add(*source_files, tprint("%/src/lauxlib.h", LUAJIT_PATH));
        array_add(*source_files, tprint("%/src/luajit.h", LUAJIT_PATH));
        array_add(*extra_clang_arguments, "-x", "c++", "-DWIN32_LEAN_AND_MEAN");
        log_unsupported = true;
    }

    return generate_bindings(opts, output_filename);
}

#import "Basic";
#import "Compiler";
#import "Bindings_Generator";
#import "File";

// FOOTER_UNIX :: #string END

// END
