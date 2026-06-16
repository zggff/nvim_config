local M = {}
M.set_keymaps = function()
    local opts = { expr = true, noremap = true, silent = true }
    vim.keymap.set({ 'i', 's' }, '<Tab>', function()
        if vim.fn.pumvisible() ~= 0 then
            return "<C-n>"
        elseif vim.snippet.active({ direction = 1 }) then
            return '<Cmd>lua vim.snippet.jump(1)<CR>'
        else
            return '<Tab>'
        end
    end, opts)

    vim.keymap.set({ 'i' }, '<S-Tab>', function()
        if vim.fn.pumvisible() ~= 0 then
            return "<C-p>"
        elseif vim.snippet.active({ direction = -1 }) then
            return '<Cmd>lua vim.snippet.jump(-1)<CR>'
        else
            return '<S-Tab>'
        end
    end, opts)

    vim.keymap.set({ 'i' }, '<cr>', function()
        if vim.fn.pumvisible() ~= 0 then
            return "<c-y>"
        else
            return '<cr>'
        end
    end, opts)

    opts.expr = nil
    vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
    vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, opts)

    vim.keymap.set("n", "<leader>ll", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>lf", "<cmd>Format<CR>", opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>li", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        vim.notify("vim.lsp.inlay_hint is now " .. tostring(vim.lsp.inlay_hint.is_enabled()), vim.log.levels.INFO)

    end, opts)
end




return M
