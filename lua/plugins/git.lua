return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = "Neogit",
        opts = {
            auto_refresh = true
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        opts = {}
    }
}
