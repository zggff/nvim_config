-- define common options
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}
local keymap = vim.keymap.set

-- set space as leader

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------
-- Normal mode --
-----------------
vim.keymap.set('n', "<leader>w", "<cmd>w!<CR>", { desc = "Save" })
vim.keymap.set('n', "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-----------------
-- Visual mode --
-----------------
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
