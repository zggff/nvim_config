vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end
  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
  augroup _haskell
    autocmd!
     autocmd FileType haskell set shiftwidth=2
     autocmd FileType haskell set tabstop=2
   augroup end
   "  augroup _asm
   "  autocmd!
   "   autocmd FileType asm set shiftwidth=2
   "   autocmd FileType asm set tabstop=2
   " augroup end

  au BufNewFile,BufRead *.wgsl set filetype=wgsl
  au BufNewFile,BufRead *.s,*.S set filetype=gas"
]])
