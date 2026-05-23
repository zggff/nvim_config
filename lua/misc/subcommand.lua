local M = {}

---@param cmd_name string
---@param subcommands table<string, function>
function M.create_command_with_subcommands(cmd_name, subcommands)
    vim.api.nvim_create_user_command(cmd_name, function(opts)
        local name = opts.fargs[1]
        local cmd = subcommands[name]
        if not cmd then
            vim.notify("Invalid Pack subcommand: " .. tostring(name))
            return
        end
        cmd()
    end, {
        nargs = "+",
        bang = true,
        range = true,
        complete = function(_, line)
            local parts = vim.split(line, "%s+")
            if #parts <= 2 then
                return vim.tbl_keys(subcommands)
            end
        end,
    })
end

return M
