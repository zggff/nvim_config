return { {
    "igorlfs/nvim-dap-view",
    dependencies = {
        "mfussenegger/nvim-dap",
        "wojciech-kulik/xcodebuild.nvim"
    },
    -- cmd = "DapViewToggle",
    config = function()
        require("config.dap")
        require("dap-view").setup {
            auto_toggle = "keep_terminal",
            winbar = {
                sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console", },
            },
            virtual_text = {
                enabled = false
            }
        }
    end,
    -- lazy = true,
} }
