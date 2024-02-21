local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.setup({
    defaults = {
        mappings = {
        },
        layout_config = {
            horizontal = {
                preview_cutoff = 0,
            },
        },
    },
    pickers = {
        buffers = {
            mappings = {
                n = {
                    ["d"] = require('telescope.actions').delete_buffer,
                }
            }
        }

    },
})

telescope.load_extension("lsp_handlers")
telescope.load_extension("ui-select")
telescope.load_extension('media_files') -- NOTE: this doesn't work with wezterm terminal emulator
