local U = {}
-- Key mapping.
local map = function(m, v, a, opts)
  vim.keymap.set(m, v, a, opts)
end

local fmt_group = vim.api.nvim_create_augroup('FORMATTING', { clear = true })
-- formatting on null-ls
function U.fmt_on_save(client, buf)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = buf })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = fmt_group,
      buffer = buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = buf })
      end,
    })
  end
end

-- avoid formatting conflicts on null-ls
U.disable_formatting = function(client)
  client.server_capabilities.document_formatting = false
  -- only use null-ls formatter
  client.server_capabilities.document_formatting = false -- disable formatter capabilities
  client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
  client.server_capabilities.documentRangeFormattingProvider = false
end

U.disgnostic_key_map_setup = function()
  local opts = { noremap = true, silent = true}
  map('n', '<leader>e', vim.diagnostic.open_float, opts)
  map('n', '[d', vim.diagnostic.goto_prev, opts)
  map('n', ']d', vim.diagnostic.goto_next, opts)
  map('n', '<leader>q', vim.diagnostic.setloclist, opts)
end

U.key_mapping = function(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr}


  map('n', 'gD', vim.lsp.buf.declaration, bufopts)
  map('n', 'gd', vim.lsp.buf.definition, bufopts)
  map('n', 'K', vim.lsp.buf.hover, bufopts)
  map('n', 'gi', vim.lsp.buf.implementation, bufopts)
  map('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
  -- map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  -- map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  map('n', 'gr', vim.lsp.buf.references, bufopts)
  map('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end

U.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

return U
