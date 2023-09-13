local dap = require("dap")


function SetDebugTarget()
    -- vim.g.dap_debug_target = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    vim.ui.input({
        prompt = "path to executable: ",
        default = vim.fn.getcwd() .. '/',
        completion = "file",
    }, function(input) vim.g.dap_debug_target = input end)

end

function SetBuildCommand()
    vim.ui.input({
        prompt = "build command: ",
        completion = "shellcmd"
    }, function(input)

        if input ~= nil then
            input = input:gsub("%%", vim.fn.expand("%"))
        end
        vim.g.dap_build_command = input

    end)
end

vim.cmd([[
command! SetDebugTarget lua SetDebugTarget()
command! SetBuildCommand lua SetBuildCommand()
]])

function MySplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

dap.adapters.lldb = {
    type = "executable",
    command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            if vim.g.dap_build_command ~= nil then
                io.popen(vim.g.dap_build_command)
            end
            if vim.g.dap_debug_target ~= nil then
                return vim.g.dap_debug_target
            end
            local cwd = vim.fn.getcwd()
            for _, val in ipairs(vim.fn.readdir(cwd)) do
                if val == "a.out" then
                    return cwd .. "/a.out"
                end
            end

            return vim.fn.input('Path to executable: ', cwd .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}
dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            if vim.g.dap_build_command ~= nil then
                io.popen(vim.g.dap_build_command)
            end
            if vim.g.dap_debug_target ~= nil then
                return vim.g.dap_debug_target
            end
            local cwd = vim.fn.getcwd()
            local buffer = vim.api.nvim_buf_get_name(0)
            local buffer_split = MySplit(buffer, "/")
            local filename = buffer_split[#buffer_split]:sub(1, -4)

            local has_cargo = false;
            local has_buffer = false;
            for _, val in ipairs(vim.fn.readdir(cwd)) do
                if val == "Cargo.toml" then
                    has_cargo = true
                elseif val == filename then
                    has_buffer = true
                end
            end
            local is_cargo_src = vim.fn.count(buffer, cwd .. "/src/") ~= 0
            local is_cargo_bin = vim.fn.count(buffer, cwd .. "/src/bin/") ~= 0
            print(is_cargo_src, is_cargo_bin)
            if is_cargo_src and has_cargo then
                local split = MySplit(cwd, "/")
                local dirname = split[#split]
                local target_directory = cwd .. "/target/debug/"
                local file_exists = false
                local target_file = dirname
                if is_cargo_bin then
                    target_file = filename
                end
                for _, val in ipairs(vim.fn.readdir(target_directory)) do
                    if val == target_file then
                        file_exists = true
                        break
                    end
                end
                if file_exists then
                    return cwd .. "/target/debug/" .. target_file
                end
            end
            if has_buffer then
                return cwd .. "/" .. filename
            end
            return vim.fn.input('Path to executable: ', cwd .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.adapters.haskell = {
    type = "executable",
    command = "haskell-debug-adapter",
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

dap.adapters.python = {
    type = "executable",
    command = "/opt/homebrew/bin/python3.11",
    args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch';
        name = "Launch file";
        program = "${file}"; -- This configuration will launch the current file if used.
        pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            else
                return '/opt/homebrew/bin/python3.11'
            end
        end;
    },
}

dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
    }
}

dap.configurations.go = {
    {
        type = "delve",
        name = "debug file",
        request = "launch",
        program = "${file}"
    },

}

vim.cmd([[
    nnoremap <silent> <F5>  :lua require'dap'.continue()<CR>
    nnoremap <silent> <F8>  :lua require'dap'.toggle_breakpoint()<CR>>
    nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
   ]])
