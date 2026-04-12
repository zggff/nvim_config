return {
    "SUSTech-data/neopyter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "AbaoFromCUG/websocket.nvim", -- for mode='direct'
    },
    cmd = "Neopyter",
    opts = {
        parser = {
            trim_whitespace = true,
        },
        mode = "direct",
        remote_address = "127.0.0.1:9001",
        file_pattern = { "*.ju.*" },
    },
    keys = {
        { "<leader>n",  group = "jupyter" },
        { "<leader>nn", "<cmd>Neopyter run current<cr>",  desc = "run current" },
        { "<leader>nm", "<cmd>Neopyter run all<cr>",      desc = "run all" },
        { "<leader>nb", "<cmd>Neopyter run allAbove<cr>", desc = "run above" },
    }
}
