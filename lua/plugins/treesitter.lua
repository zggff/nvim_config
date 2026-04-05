return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        local treesitter = require("nvim-treesitter")
        local installed = treesitter.get_installed()

        if next(installed) ~= nil then
            vim.api.nvim_create_autocmd("FileType", {
                pattern = installed,
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end
    end,

}
