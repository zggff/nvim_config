local dap = require("dap")

require("config.dap.python")
require("config.dap.lldb")

local ok, which = pcall(require, "which-key")
if ok then
    local dapview = require("dap-view")
    local keys = {
        { "<leader>k",  group = "dap" },
        { "<leader>kb", dap.toggle_breakpoint, desc = "toggle breakpoint" },
        { "<leader>kc", dap.continue,          desc = "continue" },
        { "<leader>kk", dapview.toggle,        desc = "open view" },
    }
    which.add(keys)
end

local M = {
    hover = nil
}

vim.keymap.set('n', '<F1>', dap.continue)
vim.keymap.set('n', '<F2>', dap.toggle_breakpoint)
vim.keymap.set('n', '<F3>', function()
    local widgets = require('dap.ui.widgets')
    if M.hover ~= nil then
        M.hover.close()
        M.hover = nil
        return
    end
    M.hover = widgets.hover()
end)
