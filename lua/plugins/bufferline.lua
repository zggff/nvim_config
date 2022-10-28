require("bufferline").setup({
    options = {

        mode = 'buffers',
        numbers = "ordinal",
        show_close_icon = true,
        show_buffer_close_icons = true,
        right_mouse_command = "Bdelete %d",
        diagnostics_update_in_insert = false,
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        indicator = {
            style = 'none'
        },
        diagnostics = "none"
    }

})

vim.cmd [[ 
    nnoremap <silent><leader>2 :BufferLineCycleNext<CR>
    nnoremap <silent><leader>1 :BufferLineCyclePrev<CR>

]]
