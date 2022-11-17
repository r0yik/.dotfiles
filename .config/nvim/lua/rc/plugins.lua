local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
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

vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- plugins
return packer.startup(function(use)
    use("wbthomason/packer.nvim")

    -- lua
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")

    -- colorscheme
    use("EdenEast/nightfox.nvim")
    use("lunarvim/darkplus.nvim")

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ':TSUpdate'
    })
    use("nvim-treesitter/playground")
    use("p00f/nvim-ts-rainbow")
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("onsails/lspkind.nvim")
    use("folke/lsp-colors.nvim")

    -- CMP
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/vim-vsnip")

    -- telescope
    use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })
    use { "nvim-telescope/telescope-file-browser.nvim" }

    -- status line
    use("nvim-lualine/lualine.nvim")
    use("kyazdani42/nvim-web-devicons")

    -- utility
    use("kyazdani42/nvim-tree.lua")
    use("windwp/nvim-autopairs")
    use({ "akinsho/toggleterm.nvim", tag = "*" })
    use("lukas-reineke/indent-blankline.nvim")
    use("folke/which-key.nvim")
    use("ethanholz/nvim-lastplace")
    use("norcalli/nvim-colorizer.lua")
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use({ "akinsho/bufferline.nvim", tag = "v2.*",
        config = function()
            require('bufferline').setup()
        end
    })
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    -- git
    use("lewis6991/gitsigns.nvim")

    -- greeter
    use("goolord/alpha-nvim")
end)
