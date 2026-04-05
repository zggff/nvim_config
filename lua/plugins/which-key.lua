return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>w",  "<cmd>w!<CR>",                              desc = "Save" },
        { "<leader>e",  "<cmd>NvimTreeToggle<cr>",                  desc = "Explorer" },
        { "<leader>q",  "<cmd>q<CR>",                               desc = "Quit" },
        { "<leader>f",  "<cmd>Telescope find_files<cr>",            desc = "Find files" },
        { "<leader>F",  "<cmd>Telescope live_grep<cr>",             desc = "Find Text" },
        { "<leader>b",  "<cmd>Telescope buffers<cr>",               desc = "Buffers" },
        { "<leader>c",  "<cmd>bdelete!<CR>",                        desc = "Close Buffer" },

        { "<leader>l",  group = "LSP" },
        { "<leader>ll", "<cmd>Lspsaga code_action<CR>",             desc = "Code actions" },
        { "<leader>lr", vim.lsp.buf.rename,                         desc = "rename" },
        { "<leader>lo", "<cmd>LSoutlineToggle<CR>",                 desc = "outline" },
        { "<leader>ld", "<cmd>Telescope diagnostics<CR>",           desc = "diagnostics" },
        { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>",  desc = "document symbols" },
        { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "workspace symbols" },
        { "<leader>lf", "<cmd>Format<CR>",                          desc = "format" },
        { "<leader>d",  "<cmd>Lspsaga show_line_diagnostics<cr>",   desc = "Show diagnostics" },
    },
}
