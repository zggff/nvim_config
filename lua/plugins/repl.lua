---@type PluginSpec[]
return {
    {
        "SUSTech-data/neopyter",
        disabled = true,
        dependencies = {
            'AbaoFromCUG/websocket.nvim', -- for mode='direct'
            'nvim-lua/plenary.nvim',
        },

        ---@module "neopyter"
        ---@type neopyter.Option
        opts = {
            mode = "direct",
            remote_address = "127.0.0.1:9001",
            file_pattern = { "*.ju.*" },
            parser = {
                trim_whitespace = true
            }
        },
        keys = {
            { "<Cr>",       "<cmd>Neopyter run current<cr>",  desc = "run current" },
            { "<leader>nn", "<cmd>Neopyter run current<cr>",  desc = "run all" },
            { "<leader>nm", "<cmd>Neopyter run all<cr>",      desc = "run all" },
            { "<leader>nb", "<cmd>Neopyter run allAbove<cr>", desc = "run above" },
        }

    },
    {
        "zggff/pyrepl.nvim",
        disabled = true,
        cmd = "Pyrepl",
        opts = {
            cell_pattern = function()
                if vim.bo.filetype == "markdown" then
                    return "^```python.*$"
                end
                return "^# %%%%$"
            end,
            cell_pattern_end = function()
                if vim.bo.filetype == "markdown" then
                    return "^```.*$"
                end
                return "^# %%%%.*$"
            end,
        },
        keys = {
            { "<CR>",       "<cmd>Pyrepl sendCell<cr>" },
            { "<C-CR>",     "<cmd>Pyrepl stepCellForward<cr>" },
            { "<S-CR>",     "<cmd>Pyrepl stepCellBackward<cr>" },
            { "<CR>",       "<cmd>Pyrepl sendVisual<cr>",            "v" },
            { "<leader>nm", "<cmd>Pyrepl sendCellsAll<cr>" },
            { "<leader>nb", "<cmd>Pyrepl sendCellsBeforeCurrent<cr>" },
        }

    },
    {
        "stellarjmr/ghostty-repl.nvim",
        cmd = "GhosttyRepl",
        name = "ghostty_repl",
        disabled = true,
        opts = {
            python_path = "python",
            keymaps = nil,
        },
    },
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
    }
}
