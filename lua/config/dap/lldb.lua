local dap = require('dap')

local M = {
    path = nil
}

dap.adapters.lldb = {
    type = 'executable',
    command = '/opt/homebrew/opt/llvm/bin/lldb-dap', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            if not M.path or vim.fn.executable(M.path) == 0 then
                M.path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end
            return M.path
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    } }

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.configurations.rust[1].initCommands = function()
    local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
    assert(
        vim.v.shell_error == 0,
        'failed to get rust sysroot using `rustc --print sysroot`: '
        .. rustc_sysroot
    )
    local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
    local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

    return {
        ([[!command script import '%s']]):format(script_file),
        ([[command source '%s']]):format(commands_file),
    }
end
