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
        "nvim-flutter/flutter-tools.nvim",
        cmd = "Flutter",
        opts = {}
    },
    {
        lazy = true,
        config = function()
            require("config.lsp")
        end,
        dependencies = {
            "antonk52/filepaths_ls.nvim",
            "neovim/nvim-lspconfig",
        },
    }
}
