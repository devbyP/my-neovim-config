require("twilight").setup()
local zen = require("zen-mode")
zen.setup({
    plugins = {
        tmux = { enabled = true },
        kitty = {
            enabled = true,
            font = "18",
        },
    },
    on_open = function()
        vim.cmd.colorscheme("spaceduck")
    end,
    on_close = function()
        vim.cmd.colorscheme("rose-pine")
    end,
})

vim.keymap.set('n', '<leader>z', zen.toggle, { silent = true })
