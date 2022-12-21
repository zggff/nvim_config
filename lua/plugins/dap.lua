local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

dap.adapters.lldb = {
    type = "executable",
    command = "/opt/homebrew/Cellar/llvm/15.0.6/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp


dap.adapters.haskell = {
    type = "executable",
    command = "haskell-debug-adapter",
    -- args = { "--hackage-version=0.0.33.0" },
}

dap.configurations.haskell = {
    {
        type = "haskell",
        request = "launch",
        name = "haskell(stack)",
        internalConsoleOptions = "openOnSessionStart",
        workspace = "${workspaceFolder}",
        startup = "${file}",
        startupFunc = "",
        startupArgs = "",
        stopOnEntry = false,
        mainArgs = "",
        ghciPrompt = "λ: ", --  TODO:look into ghciPrompt not working
        ghciInitialPrompt = "λ",
        ghciCmd = "stack ghci --with-ghc=ghci-dap --test --no-load --no-build --main-is . --ghci-options -fprint-evld-with-show",
        -- ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET",
        ghciEnv = vim.empty_dict(),
        logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
        logLevel = "WARNING",
        forceInspect = false,
    },
}

vim.cmd([[
    nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
    nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
   ]])
