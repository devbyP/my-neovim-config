-- COLORSCHEMES
-- see all colorschemes list at https://github.com/RRethy/nvim-base16
-- Uncomment just ONE of the following colorschemes!

-- vim.cmd('colorscheme base16-dracular')
-- vim.cmd('colorscheme base16-tender')
-- vim.cmd('colorscheme base16-nord')
-- vim.cmd('colorscheme base16-darkmoss')
-- vim.cmd('colorscheme base16-decaf')
-- vim.cmd('colorscheme base16-embers')
-- vim.cmd('colorscheme base16-oceanicnext')
-- vim.cmd('colorscheme base16-material-palenight')
-- vim.cmd('colorscheme base16-gruvbox-dark-medium')
-- vim.cmd('colorscheme base16-spaceduck')
--
-- vim.cmd('colorscheme spaceduck')
vim.cmd('colorscheme rose-pine')

function BGTransparent(t)
    if (t == true) then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        return
    end
    vim.cmd('colorscheme rose-pine')
end

BGTransparent(false)
