-- local oil_toggled = false

return {
    -- {
    -- "stevearc/oil.nvim",
    -- ---@module 'oil'
    -- ---@type oil.SetupOpts
    -- opts = {
    --     default_file_explorer = true
    -- },
    -- keys = {
    --     {
    --         "<leader>e",
    --         function()
    --             local oil = require('oil')
    --             if oil_toggled then
    --                 oil.close({
    --                     exit_if_last_buf = false
    --                 })
    --             else
    --                 oil.open(nil, {
    --                     preview = {
    --                         vertical = true
    --                     }
    --                 })
    --             end
    --             oil_toggled = not oil_toggled
    --         end,
    --         desc = "Explorer"
    --     },
    -- }
    -- }
    {
        "A7Lavinraj/fyler.nvim",
        ---@module 'fyler'
        ---@type fyler.UserConfig
        opts = {
            integrations = {
                icon = 'mini_icons'
            },
            ui = {
                
            },
            views = {
                ---@diagnostic disable-next-line: missing-fields
                finder = {
                    -- watcher = {
                    --     enabled = false,
                    -- },
                    default_explorer = true,
                }
            }
        },
        keys = {
            { "<leader>e", function()
                local fyler = require("fyler")
                fyler.toggle({ kind = "split_left_most" })
            end }
        }
    }
}
