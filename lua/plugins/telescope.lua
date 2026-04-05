return {
    "nvim-telescope/telescope.nvim",
    config = function()
        local telescope = require("telescope")

        telescope.load_extension("lsp_handlers")
        telescope.load_extension("ui-select")
        telescope.load_extension('media_files') --
    end,
    dependencies = {
        "gbrlsnchs/telescope-lsp-handlers.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-media-files.nvim",
    },
}
