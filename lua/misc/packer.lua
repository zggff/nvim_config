---@class PluginSpec
---@field [1]? string name + github path
---@field disabled? boolean
---@field lazy? boolean
---@field name? string
---@field opts? table
---@field version? string
---@field config? function
---@field init? function
---@field keys? table
---@field ft? string | string[]
---@field file_name? string | string[] 
---@field cmd? string 
---@field require_name? string 
---@field dependencies? (PluginSpec|string)[]

local L = {
    all_plugins = {},
    all_plugins_listed = {},
}

local function gf(s)
    return "https://github.com/" .. s
end

local function normalize(name)
    return name:match(".*/(.+)")
end

---@param opts PluginSpec 
---@param plugins table
local function packer_use_single(opts, plugins)
    if opts.disabled then
        return
    end
    local vals = {}
    if opts[1] then
        table.insert(vals, {
            src = gf(opts[1]),
            name = opts.name or normalize(opts[1]),
            version = opts.version
        })
    end

    if opts.dependencies ~= nil then
        for _, name in ipairs(opts.dependencies) do
            local path = gf(name)
            if not plugins.plugins_listed[name] then
                table.insert(vals, {
                    src = path,
                    name = normalize(name)
                })
            end
        end
    end

    for _, plug in ipairs(vals) do
        if not L.all_plugins_listed[plug.name] then
            L.all_plugins_listed[plug.name] = true
            table.insert(L.all_plugins, plug)
        end
    end

    if opts.config == nil and opts.opts == nil then
        for _, val in ipairs(vals) do
            plugins.plugins_listed[val.name] = true
            table.insert(plugins.plugins, val)
        end
        return
    end

    local config_func = function()
        if opts.lazy or opts.ft or opts.cmd or opts.file_name then
            vim.pack.add(vals, { confirm = false })
        end

        if opts.config then
            opts.config()
        else
            local require_name = opts.require_name or opts.name or opts[1]:match(".*/([^.]*)")
            require(require_name).setup(opts.opts)
        end

        if opts.init then
            opts.init()
        end

        if opts.keys then
            for _, key in ipairs(opts.keys) do
                local mode = key[3] or 'n'
                vim.keymap.set(mode, key[1], key[2], {
                    desc = key.desc,
                    silent = true
                })
            end
        end
    end

    if opts.file_name ~= nil then
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
            pattern = opts.file_name,
            callback = function()
                config_func()
            end
        })
    elseif opts.ft ~= nil then
        vim.api.nvim_create_autocmd('FileType', {
            pattern = opts.ft,
            callback = function()
                config_func()
            end
        })
    elseif opts.cmd ~= nil then
        local name = opts.name
        if not name and opts[1] then name = normalize(opts[1]) else name = "" end
        vim.api.nvim_create_user_command(opts.cmd, function()
            vim.api.nvim_del_user_command(opts.cmd)
            config_func()

            ---@diagnostic disable-next-line: param-type-mismatch
            pcall(vim.cmd, opts.cmd)
        end, { desc = "Initialize " .. name })
    else
        if opts.lazy then
            config_func = vim.schedule_wrap(config_func)
        else
            for _, val in ipairs(vals) do
                plugins.plugins_listed[val.name] = true
                table.insert(plugins.plugins, val)
            end
        end
        table.insert(plugins.configs, config_func)
    end
end

local function normalize_table(value)
    if value[1] and type(value[1]) == "string" then
        return { value }
    else
        return value
    end
end

local M = {}

---install all plugins specified using setup
M.install_all = function()
    vim.pack.add(L.all_plugins, { confirm = false })
end

M.update = function()
    vim.pack.update()
end

M.list = function()
    vim.pack.update(nil, { offline = true })
end

M.clear = function()
    local all_installed = vim.pack.get()
    local to_clear = {}
    for _, plug in ipairs(all_installed) do
        if not L.all_plugins_listed[plug.spec.name] then
            table.insert(to_clear, plug.spec.name)
        end
    end
    vim.pack.del(to_clear)
end

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
            else
                vim.notify("Could not read plugins from file: " .. name .. "\n: " .. tostring(ret), vim.log.levels.WARN)
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
    if not spec then
        return
    end
    local plugins = {
        plugins = {},
        plugins_listed = {},
        configs = {}
    }


    for _, plugin in ipairs(normalize_table(spec)) do
        packer_use_single(plugin, plugins)
    end

    vim.pack.add(plugins.plugins, { confirm = false })
    for _, config in ipairs(plugins.configs) do
        local res, err = pcall(config)
        if not res then
            vim.notify("Could not config plugin: " .. tostring(err), vim.log.levels.ERROR)
        end
    end
end

require("misc.subcommand").create_command_with_subcommands("Pack", {
    update = function() vim.pack.update() end,
    list = function() vim.pack.update(nil, { offline = true }) end,
    install = function() M.install_all() end,
    clear = function() M.clear() end,
})

return M
