local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local require_local = function(name)
    local status_ok, _ = pcall(require, name)
    if not status_ok then
        vim.notify('plugin config ' .. name .. ' not found')
    end
end


require("lazy").setup({

    -- DEPENDENCIES
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lua/plenary.nvim" },


    -- USEFUL STUFF
    { "nvim-tree/nvim-tree.lua",         config = function() require_local("plugins.nvim-tree") end },
    { "folke/which-key.nvim",            config = function() require_local("plugins.which-key") end },
    { "nvim-lualine/lualine.nvim",       config = function() require_local("plugins.lualine") end },
    { "akinsho/bufferline.nvim",         config = function() require_local("plugins.bufferline") end },
    { "windwp/nvim-autopairs",           config = function() require_local("plugins.autopairs") end },
    { "ahmedkhalf/project.nvim",         config = function() require_local("plugins.project") end },
    { "akinsho/toggleterm.nvim",         config = function() require_local("plugins.toggleterm") end }, -- terminal
    { "nvim-treesitter/nvim-treesitter", config = function() require_local("plugins.treesitter") end },
    { "numToStr/Comment.nvim",           config = function() require_local("plugins.comment") end },


    -- GIT
    { "lewis6991/gitsigns.nvim",         config = function() require_local("plugins.gitsigns") end },
    { "NeogitOrg/neogit",                config = function() require_local("plugins.neogit") end },
    { "sindrets/diffview.nvim"},


    -- TELESCOPE
    {
        "nvim-telescope/telescope.nvim",
        config = function() require_local("plugins.telescope") end,
        dependencies = {
            "gbrlsnchs/telescope-lsp-handlers.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-media-files.nvim"
        }
    },



    -- LSP
    {
        "neovim/nvim-lspconfig",
        config = function() require_local("plugins.lsp") end,

        dependencies = {
            "williamboman/mason.nvim",
            "mhartington/formatter.nvim",
            "williamboman/mason-lspconfig.nvim",
            "glepnir/lspsaga.nvim",
            "nvimtools/none-ls.nvim",
        }
    },


    -- CMP
    {
        "hrsh7th/nvim-cmp",
        config = function() require_local("plugins.cmp") end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "rafamadriz/friendly-snippets",
            "glepnir/lspsaga.nvim",
            "onsails/lspkind.nvim"
        }
    },



    -- COLORSCHEMES
    { "cormacrelf/dark-notify" },
    { "catppuccin/nvim",       name = "catppuccin" }
})
