local dap = require("dap")

require("config.dap.python")
require("config.dap.lldb")

local M = {
    hover = nil
}

vim.keymap.set('n', "<leader>kk", require('dap-view').toggle, { desc = "open view" })
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
