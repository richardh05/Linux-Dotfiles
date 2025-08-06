local M = {} -- Module definition

-- Your on_attach function (moved from your init.lua)
local on_attach = function(client, bufnr)
  -- Set server capabilities for completion
  client.server_capabilities.completionProvider = {
    resolveProvider = true,
    triggerCharacters = { ".", ":", "<", ">", "/" },
  }

  -- Define basic LSP keymaps that apply to any language server
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

  -- Specific commands for basedpyright (like organize imports)
  -- Check if the client supports the command before mapping
  if client.supports_method("workspace/executeCommand") then
    -- This maps <leader>oi to organize imports for basedpyright
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>oi", "<cmd>lua vim.lsp.buf.execute_command({ command = 'basedpyright.organizeimports', arguments = { vim.uri_from_bufnr(0) }})<CR>", opts)
  end
end

-- Your LSP server setup calls (moved from your init.lua)
M.setup = function()
  local lspconfig = require("lspconfig") -- You'll still need to require lspconfig in this file

  lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    cmd = { "/usr/bin/rust-analyzer" },
  })

  -- Setup the R language server
  lspconfig.r_language_server.setup({
    on_attach = on_attach, -- Use the common on_attach function
    -- Add any specific settings for r_language_server here
  })

  -- Setup basedpyright for Python
  lspconfig.basedpyright.setup({
    on_attach = on_attach, -- Use the common on_attach function
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "standard", -- or "standard", "strict"
          reportUnreachable = true,      -- basedpyright specific
          reportAny = false,             -- basedpyright specific (report usage of Any type)
        },
      },
    },
  })
  -- Add other server setups here
end

return M