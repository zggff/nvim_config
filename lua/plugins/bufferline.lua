require("bufferline").setup({
    options = {

        mode = 'buffers',
        numbers = "ordinal",
        show_close_icon = true,
        show_buffer_close_icons = true,
        diagnostics_update_in_insert = false,
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        indicator = {
            style = 'none'
        },
        diagnostics = "none"
    }

})
