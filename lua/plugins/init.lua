local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)


require("lazy").setup
{
    ---@diagnostic disable-next-line: assign-type-mismatch
    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup()

        end
    }, -- neovim config autocompletion
    { "nvim-lua/popup.nvim" }, -- popup api
    { "nvim-lua/plenary.nvim" }, -- useful lua functions used by lots of plugins
    {
        "windwp/nvim-autopairs",
        config = function()
            require("plugins.autopairs")
        end,
    }, -- autopairs, integrates with both cmp and treesitter
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require("plugins.comment")
        end,
    },
    { "kyazdani42/nvim-web-devicons" }, -- devicons for nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("plugins.nvim-tree")
        end,
    }, -- file manager
    {
        "akinsho/bufferline.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("plugins.bufferline")
        end,
    }, -- top buffer line
    { "moll/vim-bbye" }, -- api for closing buffers

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("plugins.toggleterm")
        end
    }, -- terminal
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.lualine")
        end,
    }, -- bottom line

    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("plugins.project")
        end,
    },
    {
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient").enable_profile()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.indentline")
        end,
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("plugins.alpha")
        end,
    },
    { "antoinemadec/FixCursorHold.nvim" }, -- This is needed to fix lsp doc highlight
    {
        "folke/which-key.nvim",
        config = function()
            require("plugins.whichkey")
        end,
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("plugins.trouble")
        end,
    },
    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.dap")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("plugins.dapui")
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "nvim-treesitter/nvim-treesitter", "mfussenegger/nvim-dap" },
        config = function()
            require("plugins.dap-virtual-text")
        end,
    },
    {
        "nvim-neorg/neorg",
        config = function()
            require("plugins.neorg")
        end,
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    --------COLORSCHEMES--------

    { "lunarvim/colorschemes" }, -- A bunch of colorschemes you can try out
    { "folke/lsp-colors.nvim" },
    { "Shatur/neovim-ayu" },

    { "cormacrelf/dark-notify" },
    { "olimorris/onedarkpro.nvim", config = function() require("colorschemes.onedarkpro") end },
    { "ellisonleao/gruvbox.nvim" },
    { "projekt0n/github-nvim-theme" },
    { "rose-pine/neovim", name = "rose-pine", config = function() require("colorschemes.rose-pine") end },



    --------LSP--------

    { "onsails/lspkind.nvim" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "L3MON4D3/LuaSnip", "onsails/lspkind.nvim" },
        config = function() require("plugins.cmp") end,
    },
    { "hrsh7th/cmp-buffer" }, -- buffer completions
    { "hrsh7th/cmp-path" }, -- path completions
    { "hrsh7th/cmp-cmdline" }, -- cmdline completions
    { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" }, --snippet engine
    { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

    { "neovim/nvim-lspconfig" }, -- enable LSP
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function() require("lsp.saga") end
    },
    { "williamboman/mason-lspconfig.nvim" },
    { "williamboman/mason.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim"
        },
    },

    { "tamago324/nlsp-settings.nvim" }, -- language server settings defined in json for
    { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
    { "simrat39/rust-tools.nvim" }, -- improve lsp experience for rust

    --------TELESCOPE--------

    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("plugins.telescope")
        end,
    },
    {
        "gbrlsnchs/telescope-lsp-handlers.nvim",
        requires = "nvim-telescope/telescope.nvim",
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        requires = "nvim-telescope/telescope.nvim",
    },

    --------TREESITTER--------

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end,
    },
    {
        "nvim-treesitter/playground",
        requires = "nvim-treesitter/nvim-treesitter"
    },

    --------GIT--------

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
    },
    {
        'TimUntersberger/neogit', dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("plugins.neogit")
        end,
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            require("plugins.diffview")
        end
    },
    {
        "mrjones2014/legendary.nvim",
        config = function()
            require("plugins.legendary")
        end,
    },

    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end
    },

    --------SYNTAX--------
    { "imsnif/kdl.vim" },
    { "NoahTheDuke/vim-just" },

    --------MISC--------

    -- { "mg979/vim-visual-multi" },
    { "davidgranstrom/nvim-markdown-preview" },
    { "karb94/neoscroll.nvim", config = function()
        require("neoscroll").setup()
    end },
}
