return {
    {
        'glepnir/template.nvim',
        -- cmd = 'Template',
        config = function()
            require('template').setup({
                author = "Max Giga",
                email = "gigamaximwachau@gmail.com",
                temp_dir = '~/.config/nvim/templates'
            })
        end
    }
}
