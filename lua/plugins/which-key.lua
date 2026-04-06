return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local keys = {
            { "<leader>w",  "<cmd>w!<CR>",                              desc = "Save" },
            { "<leader>e",  "<cmd>NvimTreeToggle<cr>",                  desc = "Explorer" },
            { "<leader>q",  "<cmd>q<CR>",                               desc = "Quit" },
            { "<leader>f",  "<cmd>Telescope find_files<cr>",            desc = "Find files" },
            { "<leader>F",  "<cmd>Telescope live_grep<cr>",             desc = "Find Text" },
            { "<leader>b",  "<cmd>Telescope buffers<cr>",               desc = "Buffers" },

            { "<leader>l",  group = "LSP" },
            { "<leader>ll", vim.lsp.buf.code_action,                    desc = "Code actions" },
            { "<leader>lr", vim.lsp.buf.rename,                         desc = "rename" },
            { "<leader>ld", "<cmd>Telescope diagnostics<CR>",           desc = "diagnostics" },
            { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>",  desc = "document symbols" },
            { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "workspace symbols" },
            { "<leader>lf", "<cmd>Format<CR>",                          desc = "format" },
            { "<leader>d",  vim.diagnostic.open_float,                  desc = "Show diagnostics" },
        }
        local which = require("which-key")
        which.setup()
        which.add(keys)
    end

}
