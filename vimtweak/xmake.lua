-- the debug mode
if is_mode("debug") then
    -- enable the debug symbols
    set_symbols("debug")
    -- disable optimization
    set_optimize("none")
end

-- the release mode
if is_mode("release") then
    -- set the symbols visibility: hidden
    set_symbols("hidden")
    -- enable fastest optimization
    set_optimize("fastest")
    -- strip all symbols
    set_strip("all")
end

-- add target
target("vimtweak")
    -- set kind
    set_kind("shared")
    add_links('user32')
    -- add files
    add_files("*.c") 
    set_targetdir('$(projectdir)')
    set_objectdir('$(projectdir)')
