---@type PluginSpec[]
return {
    {
        "Vigemus/iron.nvim",
        cmd = "Iron",
        disabled = true,
        config = function()
            local iron = require("iron.core")
            local view = require("iron.view")

            iron.setup {
                config = {
                    scratch_repl = true,
                    repl_definition = {
                        python = {
                            command = { "ipython", "-i" },
                            format = require("iron.fts.common").bracketed_paste,
                            block_dividers = { "# %%" }
                        },
                    },
                    repl_open_cmd = view.split.vertical("40%", {
                        winfixwidth = false,
                        winfixheight = false,
                        number = true
                    })
                },
                highlight = {
                    italic = false
                },
            }

            vim.keymap.set('n', '<CR>', function()
                iron.send_code_block()
            end)
        end
    },
    {
        "zggff/jupynvim",
        version = "fix_commands",
        file_name = { "*.ipynb" },
        opts = {
            log_level = "info",
            image_renderer = "placeholder",
            core_path = "/Users/maxgiga/dev/opt/jupynvim/core/target/release/jupynvim-core",
            keymaps = {
                run_advance = "<leader>nn",
            },
            disable_default_keymaps = true,
            explorer_keys = {},
            terminal_keys = {},
            pick_keys = {
                files = {},
                grep  = {},
            },
        },
        init = function()
            vim.api.nvim_exec_autocmds("BufReadCmd", { buffer = 0 })
        end,
        keys = {
            { "<S-cr>", "<cmd>JupynvimRunCell<cr>", desc = "run current" },
        }
    },
    {
        "milanglacier/yarepl.nvim",
        name = "yarepl",
        opts = {
            metas = {
                aichat = false,
                radian = false,
            },
        },
        cmd = "Yarepl",
        init = function()
            vim.cmd [[Yarepl start]]
        end,
        keys = {
            { "<cr>", "<cmd>Yarepl send_visual<cr>", "v", desc = "run visual" },
        }
    },

}
