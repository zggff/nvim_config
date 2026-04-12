return {
    "igorlfs/nvim-dap-view",
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    -- cmd = "DapViewToggle",
    config = function()
        require("config.dap")
        require("dap-view").setup {
            virtual_text = {
                enabled = true
            }
        }
    end,
    lazy = true,

}
