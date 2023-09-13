local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {

    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    -- ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    a = { "<cmd>Legendary<cr>", "Legendary" },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    q = { "<cmd>q<CR>", "Quit" },
    c = { "<cmd>Bdelete!<CR>", "Close Buffer" },


    w = { "<cmd>w!<CR>", "Save" },
    h = { "<cmd>nohlsearch<CR>", "No Highlight" },
    f = {
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Find files",
    },
    F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    -- ["p"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Buffers",
    },

    g = {
        name = "Git",
        g = { "<cmd>Neogit<CR>", "Lazygit" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Diff",
        },
    },
    l = {
        name = "LSP",
        l = { "<cmd>Lspsaga code_action<CR>", "Code actions" },
        r = { "<cmd>Lspsaga rename<CR>", "rename" },
        o = { "<cmd>LSoutlineToggle<CR>", "outline" },
        d = { "<cmd>Telescope diagnostics<CR>", "diagnostics" },
        s = { "<cmd>Telescope lsp_document_symbols<CR>", "document symbols" },
        S = { "<cmd>Telescope lsp_workspace_symbols<CR>", "workspace symbols" },
        f = { "<cmd>Format<CR>", "format"},

        b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle breakpoint" },
        -- B = {
        --     "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        --     "Toggle breakpoint with condition",
        -- },
        -- c = {
        --     "<cmd>lua require'dap'.continue()<cr>",
        --     "Start debugging",
        -- },
        -- C = {
        --     "<cmd>lua require'dap'.run_last()<cr>",
        --     "Restart debugging",
        -- },
        -- n = {
        --     "<cmd>lua require'dap'.step_over()<cr>",
        --     "Step over",
        -- },
        -- s = {
        --     "<cmd>lua require'dap'.step_into()<cr>",
        --     "Step into",
        -- },
        -- S = {
        --     "<cmd>lua require'dap'.step_out()<cr>",
        --     "Step out",
        -- },
        t = {
            "<cmd>lua require'dap'.repl.toggle()<cr>",
            "Toggle dap repl",
        },
        T = {
            "<cmd>lua require'dapui'.toggle()<cr>",
            "Toggle dapui",
        },
    },

    s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        s = { "<cmd>Telescope <cr>", "Telescope" },
        -- M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        -- R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
    },

    t = {
        name = "Terminal",
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    },

}

which_key.setup(setup)
which_key.register(mappings, opts)
