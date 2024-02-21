require("nvim-tree").setup({
    renderer = {
        indent_markers = {
            enable = true
        },
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            },
        },
    },
    filters = {
        dotfiles = false,
    },
    git = {
        ignore = false,
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    -- view = {
    --     mappings = {
    --         custom_only = false,
    --         list = {
    --             { key = "h", cb = tree_cb("close_node") },
    --             { key = "v", cb = tree_cb("vsplit") },
    --         },
    --     },
    -- },
})
