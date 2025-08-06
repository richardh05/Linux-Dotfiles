-- mappings, including plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function map(mode, keys, cmd)
	vim.keymap.set(mode, keys, cmd, { noremap = true, silent = true })
end

local function fileMap(mode, keys, cmd, file)
  vim.api.nvim_create_autocmd("FileType", {
  pattern = file,
  callback = function()
    -- 0 here means the buffer number
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>p', ':VimtexView<CR>', { noremap = true, silent = true })
  end
})
end

-- set leader
map("", "<Space>", "<Nop>")

-- telescope
map("n","<leader>f",":Telescope find_files<CR>")
map("n","<leader>ff",":Telescope find_files hidden=true<CR>")
map("n","<leader>fg",":Telescope git_files<CR>")

-- run / render
fileMap("n","<leader>r",":QuartoPreview<CR>","quarto")
fileMap("n","<leader>r",":VimtexView","tex")