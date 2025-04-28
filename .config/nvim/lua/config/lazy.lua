-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Plugin setup using lazy.nvim
require("lazy").setup({
  -- Syntax highlighting & Quarto support
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "quarto-dev/quarto-nvim", dependencies = { 
  "nvim-treesitter/nvim-treesitter", 
  "jmbuhr/otter.nvim" 
} },
  
  -- LSP Support
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  
  -- Snippet support
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  
  -- Navigation & Status Line
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-lualine/lualine.nvim" },

  { "rebelot/kanagawa.nvim" },
})

-- Treesitter Configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = { "r", "python", "lua", "markdown", "markdown_inline" },
  highlight = { enable = true },
})

-- LSP Configuration
local lspconfig = require("lspconfig")
lspconfig.r_language_server.setup({})
lspconfig.pyright.setup({})

-- Quarto-specific settings
require("quarto").setup({
  lspFeatures = {
      enabled = true,
      languages = { "r", "python", "lua" }
  }
})

require("kanagawa").load("wave")


