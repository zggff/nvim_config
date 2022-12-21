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


require("lazy").setup(
    {
        {
            "folke/neodev.nvim",
            config = function()
                require("neodev").setup({
                })

            end
        },
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
        },
        {
            "akinsho/bufferline.nvim",
            dependencies = { "kyazdani42/nvim-web-devicons" },
            config = function()
                require("plugins.bufferline")
            end,
        },
        {
            "akinsho/toggleterm.nvim",
            version = "*",
            config = function()
                require("plugins.toggleterm")
            end
        },
        { "moll/vim-bbye" },
        {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("plugins.lualine")
            end,
        },

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
        { "tpope/vim-fugitive" },
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
                -- require("todo-comments")
            end,
        },
        -- -- use("kg8m/vim-simple-align")
        -- --[[ use("antoyo/vim-licenses") ]]
        {
            "christoomey/vim-tmux-navigator",
            config = function()
                require("plugins.tmux")
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
        --use({
        --  "nvim-neorg/neorg",
        --config = function()
        --  require("plugins.neorg")
        -- end,
        --    requires = "nvim-lua/plenary.nvim"
        --}),

        -- Colorschemes

        { "lunarvim/colorschemes" }, -- A bunch of colorschemes you can try out
        -- use("lunarvim/darkplus.nvim")
        { "folke/lsp-colors.nvim" },
        { "Shatur/neovim-ayu" },
        { "karb94/neoscroll.nvim", config = function()
            require("neoscroll").setup()
        end },
        {
            "cormacrelf/dark-notify",
            -- config = function()
            -- require("dark_notify").run({})
            -- end
        },
        { "olimorris/onedarkpro.nvim",
            config = function()
                -- require("plugins.onedarkpro")
            end },
        { "ellisonleao/gruvbox.nvim" },
        { "projekt0n/github-nvim-theme" },
        { "onsails/lspkind.nvim" },
        {
            "hrsh7th/nvim-cmp",
            dependencies = { "L3MON4D3/LuaSnip", "onsails/lspkind.nvim" },
            config = function()
                require("plugins.cmp")
            end,
        },
        { "hrsh7th/cmp-buffer" }, -- buffer completions
        { "hrsh7th/cmp-path" }, -- path completions
        { "hrsh7th/cmp-cmdline" }, -- cmdline completions
        { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" }, --snippet engine
        { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

        -- LSP
        { "neovim/nvim-lspconfig" }, -- enable LSP
        {
            "glepnir/lspsaga.nvim",
            branch = "main",
            config = function()
                require("lsp.saga")
            end
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

        -- Telescope
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

        -- Treesitter
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
        { "NoahTheDuke/vim-just" },

        -- Git
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("plugins.gitsigns")
            end,
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
        { "imsnif/kdl.vim" },
    }
)
