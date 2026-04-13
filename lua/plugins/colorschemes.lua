return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            background = {
                light = "latte",
                dark = "mocha",
            },
        }
    },
    {
        config = function()
            local function set_colorscheme()
                if vim.o.background == "dark" then
                    vim.cmd.colorscheme("catppuccin-mocha")
                else
                    vim.cmd.colorscheme("catppuccin-latte")
                end
            end

            set_colorscheme()

            vim.api.nvim_create_autocmd("OptionSet", {
                pattern = "background",
                callback = set_colorscheme,
            })
        end
    }
}
