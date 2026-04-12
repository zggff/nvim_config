return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require("telescope")

            telescope.load_extension("lsp_handlers")
            telescope.load_extension('media_files')

            telescope.setup({
                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ["<c-d>"] = "delete_buffer",
                            }
                        }
                    }
                },
            })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "gbrlsnchs/telescope-lsp-handlers.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-media-files.nvim",
            "folke/todo-comments.nvim"
        },
        lazy = true,
    },
    {
        "folke/snacks.nvim",
        opts = {
            image = {
                math = {
                    enabled = false
                }
            }
        }
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        lazy = true,
        opts = {
            code = { border = 'thick' },
            latex = {
                render_modes = true,
                position = 'below',
            },
        }
    },

}
