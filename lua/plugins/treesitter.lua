require("nvim-treesitter.configs").setup({
    auto_install = false,
    modules = {},
    ensure_installed = {"c", "cpp", "rust", "python", "lua"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
    },
    indent = { enable = true, disable = { "" } },
})
