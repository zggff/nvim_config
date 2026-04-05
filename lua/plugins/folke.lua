return {
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
    },
}
