vim.cmd([[
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'
]])


vim.keymap.set({ 'i', 's' }, '<Tab>', function()
    if vim.snippet.active({ direction = 1 }) then
        return '<Cmd>lua vim.snippet.jump(1)<CR>'
    elseif vim.fn.pumvisible() ~= 0 then
        return "<C-n>"
    else
        return '<Tab>'
    end
end, { desc = '...', expr = true, silent = true })

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
