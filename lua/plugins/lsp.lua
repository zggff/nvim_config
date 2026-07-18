local xcode_bufnr

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
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        -- cmd = "Flutter",
        opts = {}
    },
    {
        "wojciech-kulik/xcodebuild.nvim",
        cmd = "Xcodebuild",
        dependencies = {
            "ibhagwan/fzf-lua",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("xcodebuild").setup({
                integrations = {
                    telescope_nvim = {
                        enabled = false,
                    },
                    snacks_nvim = {
                        enabled = false,
                    },
                }

            })
            require("xcodebuild.integrations.dap").setup()

            local view = require("dap-view")
            view.register_view("xcode", {
                keymap = "X",
                label = "xcode",
                action = function()
                end,
                buffer = function()
                    if not xcode_bufnr or not vim.api.nvim_buf_is_valid(xcode_bufnr) then
                        xcode_bufnr = vim.api.nvim_create_buf(false, true)
                        vim.bo[xcode_bufnr].filetype = "xcode-logs"
                    end
                    return xcode_bufnr
                end
            });
            view.setup {
                winbar = {
                    sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console", "xcode" },
                } }
            vim.api.nvim_create_user_command("XcodebuildDebug", function()
                    require("xcodebuild.integrations.dap").build_and_debug(
                        function() end
                    )
                end,
                {})
        end,
    },
    {
        lazy = true,
        config = function()
            require("config.lsp")
        end,
        dependencies = {
            "L3MON4D3/LuaSnip", -- because of swift lsp snippets doing weird unescaped backslashes
            "antonk52/filepaths_ls.nvim",
            "neovim/nvim-lspconfig",
        },
    }
}
