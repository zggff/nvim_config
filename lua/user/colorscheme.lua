vim.g.dark_theme = "rose-pine"
vim.g.light_theme = "rose-pine"

-- use dark_notify to switch between thems
local dn = require("dark_notify")
dn.run({
    schemes = {
        dark = vim.g.dark_theme,
        light = vim.g.light_theme
    }
})
dn.update()
