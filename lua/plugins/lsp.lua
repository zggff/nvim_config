return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "nvimtools/none-ls.nvim",
        ft = "python",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.yapf,
                },
            })
        end
    },
    {
        "nvim-flutter/flutter-tools.nvim",
        cmd = "Flutter"
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("config/lsp")
        end,
        dependencies = {
            "onsails/lspkind.nvim",
        },
    }
}
