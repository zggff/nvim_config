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
    -- require(name)
    local status_ok, _ = pcall(require, name)
    if not status_ok then
        vim.notify("plugin config " .. name .. " not found")
    end
end

require("lazy").setup({

    -- DEPENDENCIES
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lua/plenary.nvim" },

    -- USEFUL STUFF
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require_local("plugins.nvim-tree")
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require_local("plugins.which-key")
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require_local("plugins.autopairs")
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require_local("plugins.project")
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require_local("plugins.treesitter")
        end,

    },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    },

    -- GIT
    -- {
    --     "lewis6991/gitsigns.nvim",
    --     config = function()
    --         require('gitsigns').setup({})
    --     end,
    -- },
    {
        "NeogitOrg/neogit",
        config = function()
            require_local("plugins.neogit")
        end,
    },
    -- TELESCOPE
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require_local("plugins.telescope")
        end,
        dependencies = {
            "gbrlsnchs/telescope-lsp-handlers.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-media-files.nvim",
        },
    },

    -- LSP
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require_local("plugins.lsp")
        end,

        dependencies = {
            "glepnir/lspsaga.nvim",
            "nvimtools/none-ls.nvim",
            "nvimtools/none-ls-extras.nvim",
            "stevearc/dressing.nvim", -- optional for vim.ui.select
            "nvim-lua/plenary.nvim",
            "nvim-flutter/flutter-tools.nvim",
            "glepnir/lspsaga.nvim",
            "onsails/lspkind.nvim",

        },
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
    },
    {
        "SUSTech-data/neopyter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "AbaoFromCUG/websocket.nvim", -- for mode='direct'
        },
        opts = {
            parser = {
                trim_whitespace = true,
            },
            mode = "direct",
            remote_address = "127.0.0.1:9001",
            file_pattern = { "*.ju.*" },
        },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you use the mini.nvim suite
        opts = {},
    },

    -- COLORSCHEMES
    { "cormacrelf/dark-notify" },
    { "catppuccin/nvim",       name = "catppuccin" },
    { "rose-pine/neovim",      name = "rose-pine" },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        config = function()
            require_local("plugins.fold")
        end
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require_local("plugins.dap")
        end
    }
})
