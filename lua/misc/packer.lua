local L = {
    all_plugins = {},
    all_plugins_listed = {},
}

local function gf(s)
    return "https://github.com/" .. s
end

local function normalize(name)
    return name:match(".*/([^.]*)")
end

local function packer_use_single(opts, plugins)
    local vals = { {
        src = gf(opts[1]),
        name = opts.name or opts[1]
    } }

    if opts.dependencies ~= nil then
        for _, name in ipairs(opts.dependencies) do
            local path = gf(name)
            if not plugins.plugins_listed[path] then
                table.insert(vals, {
                    src = path,
                    name = normalize(name)
                })
            end
        end
    end

    for _, plug in ipairs(vals) do
        if not L.all_plugins_listed[plug.src] then
            L.all_plugins_listed[plug.src] = true
            table.insert(L.all_plugins, plug)
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
                config_func()
            end
        })
    elseif opts.cmd ~= nil then
        vim.api.nvim_create_user_command(opts.cmd, function()
            vim.api.nvim_del_user_command(opts.cmd)
            config_func()

            vim.cmd(opts.cmd)
        end, { desc = "Initialize " .. vals[1].name })
    else
        if opts.lazy then
            config_func = vim.schedule_wrap(config_func)
        else
            for _, val in ipairs(vals) do
                plugins.plugins_listed[val.src] = true
                table.insert(plugins.plugins, val)
            end
        end
        table.insert(plugins.configs, config_func)
    end
end

local function normalize_table(value)
    if type(value[1]) == "string" then
        return { value }
    else
        return value
    end
end

local M = {}

---install all plugins specified using setup
M.install_all = function()
    vim.pack.add(L.all_plugins)
end

M.update = function()
    vim.pack.update()
end

M.list = function()
    vim.pack.update(nil, { offline = true })
end

---@class PluginSpec
---@field [1] string plugin name
---@field opts? table
---@field ft? string
---@field cmd? string
---@field config? function
---@field dependencies? string[]
---@field keys? table[]


---require all files from directory and concat into a table
---@param path string
---@return PluginSpec[]
M.require_dir = function(path)
    local plugin_dir = vim.fn.stdpath("config") .. "/lua/" .. path
    local fs, fs_read_err = vim.uv.fs_scandir(plugin_dir)

    local res = {}

    if fs then
        while true do
            local name, _ = vim.uv.fs_scandir_next(fs)
            if not name then break end

            local mod_name = "plugins." .. name:sub(1, -5)
            local ok, ret = pcall(require, mod_name)
            if ok and type(ret) == "table" then
                for _, val in ipairs(normalize_table(ret)) do
                    table.insert(res, val)
                end
            end
        end
    else
        vim.notify("Could not read plugins directory: " .. tostring(fs_read_err), vim.log.levels.WARN)
    end
    return res
end

---setup plugin/group of plugins
---@param spec PluginSpec|PluginSpec[]
M.setup = function(spec)
    local plugins = {
        plugins = {},
        plugins_listed = {},
        configs = {}
    }


    for _, plugin in ipairs(normalize_table(spec)) do
        packer_use_single(plugin, plugins)
    end

    vim.pack.add(plugins.plugins)
    for _, config in ipairs(plugins.configs) do
        local res, err = pcall(config)
        if not res then
            vim.notify("Could not config plugin: " .. tostring(err), vim.log.levels.ERROR)
        end
    end
end

vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
end, { desc = "Update all packages" })

vim.api.nvim_create_user_command("PackList", function()
    vim.pack.update(nil, { offline = true })
end, { desc = "Update all packages" })

vim.api.nvim_create_user_command("PackInstall", function()
    M.install_all()
end, { desc = "Update all packages" })


return M
