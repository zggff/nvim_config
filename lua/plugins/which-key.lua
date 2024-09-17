local which_key = require('which-key')

which_key.setup({})
which_key.add({
    { "<leader>w",  "<cmd>w!<CR>",                                   desc = "Save" },
    { "<leader>e",  "<cmd>NvimTreeToggle<cr>",                       desc = "Explorer" },
    { "<leader>q",  "<cmd>q<CR>",                                    desc = "Quit" },
    { "<leader>f",  "<cmd>Telescope find_files<cr>",                 desc = "Find files" },
    { "<leader>F",  "<cmd>Telescope live_grep<cr>",                  desc = "Find Text" },
    { "<leader>b",  "<cmd>Telescope buffers<cr>",                    desc = "Buffers" },
    { "<leader>c",  "<cmd>bdelete!<CR>",                             desc = "Close Buffer" },
    { "<leader>1",  "<cmd>BufferLineCyclePrev<CR>",                  desc = "Next buffer" },
    { "<leader>2",  "<cmd>BufferLineCycleNext<CR>",                  desc = "Previous buffer" },

    { "<leader>l",  group = "LSP" },
    { "<leader>ll", "<cmd>Lspsaga code_action<CR>",                  desc = "Code actions" },
    { "<leader>lr", "<cmd>Lspsaga rename<CR>",                       desc = "rename" },
    { "<leader>lo", "<cmd>LSoutlineToggle<CR>",                      desc = "outline" },
    { "<leader>ld", "<cmd>Telescope diagnostics<CR>",                desc = "diagnostics" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>",       desc = "document symbols" },
    { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>",      desc = "workspace symbols" },
    { "<leader>lf", "<cmd>Format<CR>",                               desc = "format" },
    { "<leader>lb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
    { "<leader>lt", "<cmd>lua require'dap'.repl.toggle()<cr>",       desc = "Toggle dap repl" },
    { "<leader>lT", "<cmd>lua require'dapui'.toggle()<cr>",          desc = "Toggle dapui" },
    { "<leader>d",  desc = "Show diagnostics" },
})
