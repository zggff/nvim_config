local plugin_info = {
    startup_plugins = {},
    configs = {},
    keymaps = {}
}

local function gf(s)
    return "https://github.com/" .. s
end

local function normalize(name)
    return name:match(".*/([^.]*)")
end

local function add_to_packer(opts)
    local vals = { {
        src = gf(opts[1]),
        name = opts.name or opts[1]
    } }

    if opts.dependencies ~= nil then
        for _, name in ipairs(opts.dependencies) do
            local path = gf(name)
            for _, ex in ipairs(plugin_info.startup_plugins) do
                if path == ex.src then
                    goto exists
                end
            end
            table.insert(vals, {
                src = path,
                name = normalize(name)
            })
            ::exists::
        end
    end

    if opts.config == nil and opts.opts == nil then
        return
    end

    local require_name = opts.require_name or opts.name or normalize(opts[1])
    local config_func = function()
        if opts.lazy or opts.ft or opts.cmd then
            vim.pack.add(vals)
        end

        if opts.keys then
            for _, key in ipairs(opts.keys) do
                vim.keymap.set('n', key[1], key[2], {
                    desc = key.desc,
                    silent = true
                })
            end
        end

        if opts.init then
            opts.init()
        end

        if opts.config then
            opts.config()
        else
            require(require_name).setup(opts.opts)
        end
    end

    if opts.ft ~= nil then
        vim.api.nvim_create_autocmd('FileType', {
            pattern = opts.ft,
            callback = function()
                -- vim.pack.add(vals)
                config_func()
            end
        })
    elseif opts.cmd ~= nil then
        vim.api.nvim_create_user_command(opts.cmd, function()
            vim.api.nvim_del_user_command(opts.cmd)
            -- vim.pack.add(vals)
            config_func()

            vim.cmd(opts.cmd)
        end, { desc = "Initialize " .. vals[1].name })
    else
        if opts.lazy then
            config_func = vim.schedule_wrap(config_func)
        else
            for _, val in ipairs(vals) do
                table.insert(plugin_info.startup_plugins, val)
            end
        end
        table.insert(plugin_info.configs, config_func)
    end
end

local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local fs, fs_read_err = vim.uv.fs_scandir(plugin_dir)

if fs then
    while true do
        local name, _ = vim.uv.fs_scandir_next(fs)
        if not name then break end

        local mod_name = "plugins." .. name:sub(1, -5)
        local ok, ret = pcall(require, mod_name)
        if ok and type(ret) == "table" then
            if type(ret[1]) == "string" then
                add_to_packer(ret)
            else
                for _, plugin in ipairs(ret) do
                    if type(plugin) == "table" then
                        add_to_packer(plugin)
                    end
                end
            end
        end
    end
else
    vim.notify("Could not read plugins directory: " .. tostring(fs_read_err), vim.log.levels.WARN)
end

vim.pack.add(plugin_info.startup_plugins)

local function time_it(fn)
    local start = vim.loop.hrtime()
    fn()
    local elapsed = (vim.loop.hrtime() - start) / 1e6
    print(string.format("Took %.3f ms", elapsed))
end

for _, config in ipairs(plugin_info.configs) do
    local res, err = pcall(config)
    if not res then
        vim.notify("Could not config plugin: " .. tostring(err), vim.log.levels.ERROR)
    end
end


-- vim.api.nvim_create_user_command("PackUpdate", function()
--     vim.pack.update()
-- end, { desc = "Update all packages" })
--
-- vim.api.nvim_create_user_command("PackList", function()
--     vim.pack.update(nil, { offline = true })
-- end, { desc = "Update all packages" })
