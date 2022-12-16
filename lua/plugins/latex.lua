-- vim.api.nvim_set_keymap("n", "<leader>r", ":!zathura <C-r>=expand('%:r')<cr>.pdf &<cr>",
--     { noremap = true, silent = true })


vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = 'abdmgs'
vim.g.indentLine_setConceal = 0
