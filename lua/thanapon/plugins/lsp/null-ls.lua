local nls = require('null-ls')
local U = require('thanapon.plugins.lsp.config')

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics
local cda = nls.builtins.code_actions

-- Configuring null-ls
nls.setup({
  sources = {
    ----------------
    -- FORMATTING --
    ----------------
    -- fmt.trim_whitespace.with({
    --     filetypes = { 'text', 'zsh', 'toml', 'make', 'conf', 'tmux' },
    -- }),
    -- NOTE:
    -- 1. both needs to be enabled to so prettier can apply eslint fixes
    -- 2. prettierd should come first to prevent occassional race condition
    fmt.prettier,
    fmt.eslint_d,
    fmt.sql_formatter,
    -- fmt.prettier.with({
    --     extra_args = {
    --         '--tab-width=4',
    --         '--trailing-comma=es5',
    --         '--end-of-line=lf',
    --         '--arrow-parens=always',
    --     },
    -- }),
    fmt.rustfmt,
    -- fmt.stylua,
    fmt.gofmt,
    -----------------
    -- DIAGNOSTICS --
    -----------------
    dgn.eslint_d,
    dgn.luacheck.with({
      extra_args = { '--globals', 'vim', '--std', 'luajit' },
    }),
    ------------------
    -- CODE ACTIONS --
    ------------------
    cda.eslint_d,
  },
  on_attach = function(client, bufnr)
    U.fmt_on_save(client, bufnr)
    U.key_mapping(bufnr)
  end,
})
