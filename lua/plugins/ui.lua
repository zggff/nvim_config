return {
    {
        "folke/snacks.nvim",
        lazy = true,
        opts = {
            image = {
                math = {
                    enabled = false
                }
            },
            input = {}
        }
    },
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        dependencies = { "nvim-mini/mini.icons" },
        ---@module "fzf-lua"
        ---@type fzf-lua.Config|{}
        ---@diagnostic disable: missing-fields
        ---@diagnostic disable: assign-type-mismatch
        opts = {
            global = {
                _treesitter = false -- fixes highlighting with global
            },
            fzf_colors = {
                true
            },
        },
        ---@diagnostic enable: missing-fields
        ---@diagnostic enable: assign-type-mismatch
        init = function ()
            require("fzf-lua").register_ui_select()
        end,
        keys = {
            { "<leader>f", function() require("fzf-lua").global() end },
            { "<leader>b", function() require("fzf-lua").buffers() end },
            { "<leader>F", function() require("fzf-lua").live_grep_native() end },
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
