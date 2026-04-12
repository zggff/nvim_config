local oil_toggled = false

return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true
    },
    keys = {
        {
            "<leader>e",
            function()
                local oil = require('oil')
                if oil_toggled then
                    oil.close()
                else
                    oil.open(nil, {
                        preview = {
                            vertical = true
                        }
                    })
                end
                -- oil.toggle_float()
            end,
            desc = "Explorer"
        },
    }
}
