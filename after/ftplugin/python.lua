vim.api.nvim_create_autocmd(
    "BufEnter", {
        callback = function(args)
            if string.match(args.file, ".ju.py") then
                local ok, which_key = pcall(require, "which-key")
                if not ok then
                    return
                end
                which_key.add(
                    {
                        { "<leader>n",  group = "jupyter" },
                        { "<leader>nn", "<cmd>Neopyter run current<cr>",  desc = "run current" },
                        { "<leader>nm", "<cmd>Neopyter run all<cr>",      desc = "run all" },
                        { "<leader>nb", "<cmd>Neopyter run allAbove<cr>", desc = "run above" },
                    }
                )
            end
        end
    }
)
