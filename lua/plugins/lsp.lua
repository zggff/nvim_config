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
        "neovim/nvim-lspconfig",
        config = function()
            require("config/lsp")
        end,
        dependencies = {
            "onsails/lspkind.nvim",
            "antonk52/filepaths_ls.nvim"
        },
        keys = {
            { "<leader>ll", vim.lsp.buf.code_action,   desc = "Code actions" },
            { "<leader>lr", vim.lsp.buf.rename,        desc = "rename" },
            { "<leader>lf", "<cmd>Format<CR>",         desc = "format" },
            { "<leader>d",  vim.diagnostic.open_float, desc = "Show diagnostics" },
        }
    }
}
