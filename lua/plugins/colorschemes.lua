return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                background = { -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                term_colors = false,
                dim_inactive = {
                    enabled = false
                }
            })
        end
    },
    { "rose-pine/neovim", name = "rose-pine" },

    {
        "cormacrelf/dark-notify",
        config = function()
            vim.g.dark_theme = "rose-pine"

            vim.g.dark_theme = "catppuccin"
            vim.g.light_theme = "catppuccin"

            local dn = require("dark_notify")
            dn.run({
                schemes = {
                    dark = vim.g.dark_theme,
                    light = vim.g.light_theme
                }
            })
            dn.update()
        end,
        dependencies = {
            "catppuccin/nvim",
            "rose-pine/neovim"
        }
    },
}
