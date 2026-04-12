return {
    "stevearc/oil.nvim",
    opts = {
        default_file_explorer = true
    },
    keys = {
        {
            "<leader>e",
            function()
                local oil = require('oil')
                oil.toggle_float()
            end,
            desc = "Explorer"
        },
    }
}
