local nls = require("null-ls")

nls.setup({
    sources = {
        nls.builtins.formatting.prettier.with({
            --file_type = {
            --    "javascript",
            --    "javascriptreact",
            --    "typescript",
            --    "typescriptreact",
            --    "vue",
            --    "css",
            --    "scss",
            --    "less",
            --    "html",
            --    "json",
            --    "jsonc",
            --    "yaml",
            --    "markdown",
            --    "markdown.mdx",
            --    "graphql",
            --    "handlebars",
            --},
            extra_args = { "--tab-width=4" }
        }),
    },
})
