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
        vim.notify("plugin config " .. name .. " not found")
    end
end

require("lazy").setup({

    -- DEPENDENCIES
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lua/plenary.nvim" },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
        config = true,
    },

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
        "nvim-lualine/lualine.nvim",
        config = function()
            require('lualine').setup({})
        end,
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require_local("plugins.bufferline")
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
    -- {
    -- 	"akinsho/toggleterm.nvim",
    -- 	config = function()
    -- 		require_local("plugins.toggleterm")
    -- 	end,
    -- }, -- terminal
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require_local("plugins.treesitter")
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    },

    -- GIT
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({})
        end,
    },
    {
        "NeogitOrg/neogit",
        config = function()
            require_local("plugins.neogit")
        end,
    },
    { "sindrets/diffview.nvim" },

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
            "nvim-treesitter/nvim-treesitter", -- neopyter don't depend on `nvim-treesitter`, but does depend on treesitter parser of python
            "AbaoFromCUG/websocket.nvim",      -- for mode='direct'
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
    -- CMP
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require_local("plugins.cmp")
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            -- "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "rafamadriz/friendly-snippets",
            "glepnir/lspsaga.nvim",
            "onsails/lspkind.nvim",
        },
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
