if vim.g.neovide then
    local keymapOpts = {
        silent = true,
        noremap = true,
    }
    vim.keymap.set({ "n", "v" }, "<D-v>", "\"*p", keymapOpts);
    vim.keymap.set({ "n", "v" }, "<D-c>", "\"*y", keymapOpts);
    vim.keymap.set({ "n", "v" }, "<D-x>", "\"*x", keymapOpts);
    vim.keymap.set({ "i" }, "<D-v>", "<Esc>pa", keymapOpts);


    vim.cmd [[
        let g:neovide_hide_mouse_when_typing = v:true
    ]]
end
