return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            integrations = {
                fzf = true
            }
        }
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {}
    },
    {
        "folke/tokyonight.nvim",
        opts = {},
    },
    {
        "f-person/auto-dark-mode.nvim",
        lazy = true,
        opts = {}
    },
    {
        config = function()
            vim.g.colorscheme_light = "catppuccin-latte"
            vim.g.colorscheme_dark = "catppuccin-macchiato"
            local function set_colorscheme()
                if vim.o.background == "dark" then
                    vim.cmd.colorscheme(vim.g.colorscheme_dark)
                else
                    vim.cmd.colorscheme(vim.g.colorscheme_light)
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
