vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.showmode = false
vim.opt.pumheight = 10

vim.opt.hlsearch = false

vim.opt.signcolumn = 'yes:1' -- for gitsigns
vim.g.python3_host_prog = '/Users/maxgiga/.local/bin/pynvim-python'
vim.g.c_syntax_for_h = 1
vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true



local opts = {
    noremap = true,
    silent = true,
}

vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', "<leader>w", "<cmd>w!<CR>", opts)
vim.keymap.set('n', "<leader>q", "<cmd>q<CR>", opts)

vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
