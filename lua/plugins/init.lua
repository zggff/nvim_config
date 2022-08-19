local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use("wbthomason/packer.nvim") -- bootstrap the packer
    use("nvim-lua/popup.nvim") -- popup api
    use("nvim-lua/plenary.nvim") -- useful lua functions used by lots of plugins
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("plugins.autopairs")
        end,
    }) -- autopairs, integrates with both cmp and treesitter
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.comment")
        end,
    }) -- easily comment stuff
    use("kyazdani42/nvim-web-devicons") -- devicons for nvim-tree
    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("plugins.nvim-tree")
        end,
    }) -- file manager
    use({
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.bufferline")
        end,
    })
    use("moll/vim-bbye")
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.lualine")
        end,
    })
    use({
        "akinsho/toggleterm.nvim",
        tag = "v2.*",
        config = function()
            require("plugins.toggleterm")
        end,
    })
    use({
        "ahmedkhalf/project.nvim",
        config = function()
            require("plugins.project")
        end,
    })
    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("impatient").enable_profile()
        end,
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.indentline")
        end,
    })

    use({
        "goolord/alpha-nvim",
        config = function()
            require("plugins.alpha")
        end,
    })
    use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
    use({
        "folke/which-key.nvim",
        config = function()
            require("plugins.whichkey")
        end,
    })
    use("tpope/vim-fugitive")
    use({
        "folke/trouble.nvim",
        config = function()
            require("plugins.trouble")
        end,
    })
    use({
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments")
        end,
    })
    use("kg8m/vim-simple-align")
    --[[ use("antoyo/vim-licenses") ]]
    use({
        "christoomey/vim-tmux-navigator",
        config = function()
            require("plugins.tmux")
        end,
    })
    use({
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.dap")
        end,
    })
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("plugins.dapui")
        end,
    })
    use({
        "theHamsta/nvim-dap-virtual-text",
        requires = { "nvim-treesitter/nvim-treesitter", "mfussenegger/nvim-dap" },
        config = function()
            require("plugins.dap-virtual-text")
        end,
    })
    use({
        "nvim-neorg/neorg",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("neorg")
        end,
    })
    -- Colorschemes

    -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
    -- use("lunarvim/darkplus.nvim")
    use("folke/lsp-colors.nvim")
    -- use("Shatur/neovim-ayu")
    use({
        "cormacrelf/dark-notify",
        config = function()
            require("dark_notify").run({})
        end
    })
    use({ "olimorris/onedarkpro.nvim",
        config = function()
            -- require("plugins.onedarkpro")
        end })
    -- use("projekt0n/github-nvim-theme")
    --  NOTE
    -- cmp plugins
    use({
        "hrsh7th/nvim-cmp",
        requires = "L3MON4D3/LuaSnip",
        config = function()
            require("plugins.cmp")
        end,
    }) -- The completion plugin
    use("hrsh7th/cmp-buffer") -- buffer completions
    use("hrsh7th/cmp-path") -- path completions
    use("hrsh7th/cmp-cmdline") -- cmdline completions
    use("saadparwaiz1/cmp_luasnip") -- snippet completions
    use("hrsh7th/cmp-nvim-lsp")
    -- snippets
    use("L3MON4D3/LuaSnip") --snippet engine
    use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

    -- LSP
    use("neovim/nvim-lspconfig") -- enable LSP
    use { "williamboman/mason-lspconfig.nvim", }
    use { "williamboman/mason.nvim",
        requires = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim"
        },
        config = function() require("lsp") end }

    use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
    use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
    use("simrat39/rust-tools.nvim") -- improve lsp experience for rust
    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        config = function()
            require("plugins.telescope")
        end,
    })
    use({
        "gbrlsnchs/telescope-lsp-handlers.nvim",
        requires = "nvim-telescope/telescope.nvim",
    })
    use({
        "nvim-telescope/telescope-ui-select.nvim",
        requires = "nvim-telescope/telescope.nvim",
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end,
    })

    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- Git
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
