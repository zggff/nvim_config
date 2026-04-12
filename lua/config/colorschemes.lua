local packer = require("misc.packer")
packer.setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            background = {
                light = "latte",
                dark = "mocha",
            },
            term_colors = false,
            dim_inactive = {
                enabled = false
            }
        }
    }
})

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
