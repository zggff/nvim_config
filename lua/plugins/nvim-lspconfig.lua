return {
    "neovim/nvim-lspconfig",
    config = function()
        require("config/lsp")
    end,

    dependencies = {
        "glepnir/lspsaga.nvim",
        "nvimtools/none-ls.nvim",
        "nvimtools/none-ls-extras.nvim",
        "nvim-flutter/flutter-tools.nvim",
        "glepnir/lspsaga.nvim",
        "onsails/lspkind.nvim",

    },
}
