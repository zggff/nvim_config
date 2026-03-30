local treesitters = { "rust", "swift", "c", "cpp", "markdown", "markdown_inline", "python", "lua" }

require("nvim-treesitter").install(treesitters)

vim.api.nvim_create_autocmd("FileType", {
    pattern = treesitters,
    callback = function()
        vim.treesitter.start()
    end,
})
