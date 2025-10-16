local util = require("util")
local term = require("terminal")

local function run()
    local path = vim.api.nvim_buf_get_name(0)
    local work = vim.fn.getcwd(0, 0)
    path = path:gsub(work, ".")
    term.run({
        "go",
        "run",
        path
    }, path)
end


local function test()
    local path = vim.api.nvim_buf_get_name(0)
    path = util.parent(path)
    local test_files = vim.fn.split(vim.fn.globpath(path, "*test.go"), "\n")
    if #test_files == 0 then
        vim.print("nothing to test")
    end
    path = util.parent(test_files[1])
    term.run({
        "go",
        "test",
        "-v",
        path
    }, path)
end

vim.api.nvim_buf_create_user_command(0, "Run", run, {})
vim.api.nvim_buf_create_user_command(0, "Test", test, {})

local ok, which_key = pcall(require, "which-key")
if not ok then
    return
end
if not which_key.did_setup then
    return
end
which_key.add({
    { "<leader>l;", run, desc = "run buffer in terminal" },
    { "<leader>l,", test, desc = "test buffer in terminal" },
})
