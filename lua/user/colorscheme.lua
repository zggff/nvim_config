require("onedarkpro").setup({
    options = {
        bold = true, -- Use the themes opinionated bold styles?
        italic = true, -- Use the themes opinionated italic styles?
        underline = true, -- Use the themes opinionated underline styles?
        undercurl = true, -- Use the themes opinionated undercurl styles?
        cursorline = true, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
    },
})
-- require('ayu').setup({
--     mirage = true
-- })



-- use dark_notify to switch between thems
local dn = require("dark_notify")
dn.configure({
    schemes = {
        dark = "onedark_vivid",
        light = "onelight"
    }
})
-- dn.update()
dn.run()
dn.run()

-- require("ayu").colorscheme()
-- vim.cmd([[colorscheme ayu]])
-- vim.g.colors_name = "ayu"
-- vim.g.colors = "ayu"
