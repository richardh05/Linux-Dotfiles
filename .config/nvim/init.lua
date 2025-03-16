-- Set basic options
vim.opt.number = true  -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.tabstop = 4  -- Number of spaces per tab
vim.opt.shiftwidth = 4  -- Spaces per indentation level
vim.opt.autoindent = true  -- Enable auto-indentation
vim.opt.mouse = "a"  -- Enable mouse support
vim.opt.termguicolors = false  -- Disable terminal GUI colors
require("config.lazy")
