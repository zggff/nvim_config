local function set_colorscheme()
    if vim.o.background == "dark" then
        vim.cmd.colorscheme("catppuccin")
    else
        vim.cmd.colorscheme("catppuccin")
    end
end

set_colorscheme()

vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    callback = set_colorscheme,
})
