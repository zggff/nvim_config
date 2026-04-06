return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            background = {     -- :h background
                light = "latte",
                dark = "mocha",
            },
            term_colors = false,
            dim_inactive = {
                enabled = false
            }
        }
    },
    -- { "rose-pine/neovim", name = "rose-pine" },
    {
        "cormacrelf/dark-notify",
        config = function()
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
