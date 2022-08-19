local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}


local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

lualine.setup({
    options = {
        theme = "auto",
        component_separators = "|",
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            "alpha",
            "dashboard",
            "NvimTree",
            "Outline",
            "dapui_scopes",
            "dapui_breakpoints",
            "dapui_stacks",
            "dapui_watches",
            "dap-repl",
            "toggleterm",
            "Trouble",
        },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = " " }, right_padding = 2 },
            diagnostics,
        },
        lualine_b = { "filename", branch },
        lualine_c = {},
        lualine_x = { { "diff", colored = false } },
        lualine_y = { { "filetype", icons_enabled = false, icon = nil }, { "progress", right_padding = 3 } },
        lualine_z = {
            { "location", separator = { right = " " }, left_padding = 4 },
        },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
    tabline = {},
    extensions = {},
})
