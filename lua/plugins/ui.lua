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
        keys = {
            { "<leader>f",  "<cmd>Telescope find_files<cr>",            desc = "Find files" },
            { "<leader>t",  "<cmd>Telescope<cr>",                       desc = "Find files" },
            { "<leader>F",  "<cmd>Telescope live_grep<cr>",             desc = "Find Text" },
            { "<leader>b",  "<cmd>Telescope buffers<cr>",               desc = "Buffers" },
            { "<leader>ld", "<cmd>Telescope diagnostics<CR>",           desc = "diagnostics" },
            { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>",  desc = "document symbols" },
            { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "workspace symbols" },
        },
        lazy = true,
    },
    {
        "folke/snacks.nvim",
        lazy = true,
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
