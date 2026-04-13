return {
    {
        "SUSTech-data/neopyter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "AbaoFromCUG/websocket.nvim", -- for mode='direct'
        },
        cmd = "Neopyter",
        opts = {
            parser = {
                trim_whitespace = true,
            },
            mode = "direct",
            remote_address = "127.0.0.1:9001",
            file_pattern = { "*.ju.*" },
        },
        keys = {
            { "<leader>nn", "<cmd>Neopyter run current<cr>",  desc = "run current" },
            { "<leader>nm", "<cmd>Neopyter run all<cr>",      desc = "run all" },
            { "<leader>nb", "<cmd>Neopyter run allAbove<cr>", desc = "run above" },
        }
    },
    {
        'stellarjmr/notebook_style.nvim',
        ft = 'python',
        config = function()
            require('notebook_style').setup(
                {
                    manual_render = false
                }
            )
        end
    },
    {
        "dangooddd/pyrepl.nvim",
        opts = {},
        config = function()
            local pyrepl = require("pyrepl")
            pyrepl.setup()

            vim.keymap.set("n", "<leader>jo", pyrepl.open_repl)
            vim.keymap.set("n", "<leader>jh", pyrepl.hide_repl)
            vim.keymap.set("n", "<leader>jc", pyrepl.close_repl)
            vim.keymap.set("n", "<leader>jt", pyrepl.toggle_repl)
            vim.keymap.set("n", "<leader>ji", pyrepl.open_image_history)
            vim.keymap.set({ "n", "t" }, "<C-j>", pyrepl.toggle_repl_focus)

            -- send commands
            vim.keymap.set("n", "<leader>jb", pyrepl.send_buffer)
            vim.keymap.set("n", "<leader>jl", pyrepl.send_cell)
            vim.keymap.set("v", "<leader>jv", pyrepl.send_visual)

            -- QoL commands
            vim.keymap.set("n", "<leader>jp", pyrepl.step_cell_backward)
            vim.keymap.set("n", "<leader>jn", pyrepl.step_cell_forward)
            vim.keymap.set("n", "<leader>je", pyrepl.export_to_notebook)
            vim.keymap.set("n", "<leader>js", ":PyreplInstall")
        end,
    }
}
