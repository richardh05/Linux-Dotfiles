vim.g.mapleader = " "        -- Space as global leader
vim.g.maplocalleader = " "   -- Comma as local leader

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


-- Plugin installation and setup using lazy.nvim
require("lazy").setup({
  -- LSP Support
 { "neovim/nvim-lspconfig",
    config = function()
    require("config.lsp").setup() -- Call the setup function defined in lsp/init.lua
    end,
  },


  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source
      "hrsh7th/cmp-buffer",   -- Buffer words source
	 	 	"L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip", -- LuaSnip source
    },
	config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip") -- Make sure LuaSnip is required here if needed

      cmp.setup({
      	-- Enable LSP, LuaSnip and Buffer completion sources
      	sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
      }),
	  mapping = cmp.mapping.preset.insert({
	  	["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter accepts completion item
	  	["<Tab>"] = cmp.mapping.confirm({ select = true }),
  	  ["<A-l>"] = cmp.mapping.confirm({ select = true }),
  	  ["<A-j>"] = cmp.mapping.select_next_item(),
  		["<A-k>"] = cmp.mapping.select_prev_item(),
			['<A-h>'] = cmp.mapping.abort(),
	  }),
	  -- Enable snippets
      	snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` snippets
          end,
      	},
      -- Appearance (optional, but good for usability)
      	window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
      	},
      })
  	end,
  },

  -- Syntax highlighting
  { "nvim-treesitter/nvim-treesitter", 
  	build = ":TSUpdate", 
		config = function()
	  	require("nvim-treesitter.configs").setup({
  			ensure_installed = { "r", "python", "lua", "markdown", "markdown_inline" },
  			highlight = { enable = true },
      })
	end
  },
  
  -- quarto support
  { "quarto-dev/quarto-nvim", 
    dependencies = { "nvim-treesitter/nvim-treesitter", "jmbuhr/otter.nvim" },
  },
    
  -- Navigation & Status Line
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-lualine/lualine.nvim", 
		dependencies = {'nvim-tree/nvim-web-devicons'}, 
			config = function()
	  	require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto", --auto allows for theme switching
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				always_divide_middle = true,
			},
			
			-- extensions = { 'nvim-tree' },
			})
			end
		},


  { "rebelot/kanagawa.nvim"},
})

require("config.quarto")
require("config._options")
require("config._keybinds")
require("kanagawa").load("wave")