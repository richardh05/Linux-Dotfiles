-- Set basic options
vim.opt.number = true  -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.tabstop = 4  -- Number of spaces per tab
vim.opt.shiftwidth = 4  -- Spaces per indentation level
vim.opt.autoindent = true  -- Enable auto-indentation
vim.opt.mouse = "a"  -- Enable mouse support
-- vim.opt.termguicolors = false  -- Disable terminal GUI colors
require("config.lazy")

vim.g.mapleader = " "        -- Space as global leader
vim.g.maplocalleader = ","   -- Comma as local leader
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files hidden=true<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "quarto",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>p', ':QuartoPreview<CR>', { noremap = true, silent = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>p', ':VimtexView<CR>', { noremap = true, silent = true })
  end
})



