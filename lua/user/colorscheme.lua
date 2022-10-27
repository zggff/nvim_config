local onedarkpro_status_ok, onedarkpro = pcall(require, "onedarkpro")
if not onedarkpro_status_ok then
    return
end

onedarkpro.setup({
    theme = function()
        if vim.o.background == "dark" then
            return "onedark"
        else
            return "onelight"
        end
    end,

    options = {
        bold = true, -- Use the themes opinionated bold styles?
        italic = true, -- Use the themes opinionated italic styles?
        underline = true, -- Use the themes opinionated underline styles?
        undercurl = true, -- Use the themes opinionated undercurl styles?
        cursorline = true, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        window_unfocused_color = true, -- When the window is out of focus, change the normal background?
    },
})



onedarkpro.load()
