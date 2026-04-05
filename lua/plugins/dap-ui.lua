return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    cmd = "DapInit",
    config = function()
        require("dapui").setup()
    end
}
