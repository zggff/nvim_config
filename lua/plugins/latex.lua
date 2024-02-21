-- vim.api.nvim_set_keymap("n", "<leader>r", ":!zathura <C-r>=expand('%:r')<cr>.pdf &<cr>",
--     { noremap = true, silent = true })


-- vim.cmd[[let maplocalleader = ""]]
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'

-- vim.cmd[[
-- let g:vimtex_compiler_latexmk_engines = {
--         \ '_'                : '-lualatex',
--         \ 'pdfdvi'           : '-pdfdvi',
--         \ 'pdfps'            : '-pdfps',
--         \ 'pdflatex'         : '-pdf',
--         \ 'luatex'           : '-lualatex',
--         \ 'lualatex'         : '-lualatex',
--         \ 'xelatex'          : '-xelatex',
--         \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
--         \ 'context (luatex)' : '-pdf -pdflatex=context',
--         \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
--         \}
-- ]]

