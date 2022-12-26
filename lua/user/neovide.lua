if not vim.g.neovide then
    return
end

vim.g.neovide_hide_mouse_when_typing = true
vim.g.gui_font_default_size = 16
vim.g.neovide_transparency = 1.0
vim.g.neovide_floating_blur_amount_x = 0
vim.g.neovide_floating_blur_amount_y = 0
vim.g.neovide_scroll_animation_length = 0.0
vim.g.neovide_underline_automatic_scaling = false
vim.g.neovide_input_macos_alt_is_meta = false
vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_font_hinting = "none"
vim.g.neovide_font_edging = "antialias"



vim.g.fonts = {
    "Cascadia Code",
    "CaskaydiaCove Nerd Font"
}
vim.g.gui_font_size = vim.g.gui_font_default_size


local opts = { noremap = true, silent = true }
vim.keymap.set({ 'n', 'i' }, "<D-=>", function() ResizeGuiFont(1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<D-->", function() ResizeGuiFont(-1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<D-Bslash>", function() ResetGuiFont() end, opts)
vim.keymap.set({ "n", "v" }, "<D-v>", "\"*p", opts);
vim.keymap.set({ "n", "v" }, "<D-c>", "\"*y", opts);
vim.keymap.set({ "n", "v" }, "<D-x>", "\"*x", opts);
vim.keymap.set({ "i" }, "<D-v>", "<Esc>pa", opts);
vim.keymap.set({ "t" }, "<D-v>", [[<C-\>p<C-n>]], opts);

RefreshGuiFont = function()
    local font_string = ""
    for _, font in ipairs(vim.g.fonts) do
        font_string = font_string .. font .. ","
    end
    vim.opt.guifont = font_string:sub(1, -2) ..
        string.format(":h%s:#h-%s:#e-%s", vim.g.gui_font_size, vim.g.neovide_font_hinting, vim.g.neovide_font_edging)
end

ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
end

ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
end

ResetGuiFont()
