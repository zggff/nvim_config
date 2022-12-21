local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "hint" },
    symbols = { error = " ", warn = " ", hint = " " },
    colored = true,
    update_in_insert = false,
    always_visible = false,
}


local branch = {
    "branch",
    separator = {},
    icon = " ",
}

local filetype = {
    "filetype",
    icons_enabled = false
}

require("lualine").setup({
    options = {
        theme = "auto",
        component_separators = "|",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { branch, "diff" },
        lualine_c = { diagnostics },
        lualine_x = { "filename" },
        lualine_y = { filetype, "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
})
