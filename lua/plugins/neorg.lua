local neorg = require("neorg")

neorg.setup {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
        },
        ["core.completion"] = {
            config = { -- Note that this table is optional and doesn't need to be provided
                engine = "nvim-cmp"
                -- Configuration here
            }
        }
    }
}
