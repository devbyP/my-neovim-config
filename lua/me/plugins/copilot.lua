return {
	"github/copilot.vim",
	config = function()
		-- disable when init
		vim.cmd("Copilot disable")
		vim.keymap.set("n", "<leader>co", ":Copilot enable<CR>", { desc = "[C]opilot [o]n" })
		vim.keymap.set("n", "<leader>cf", ":Copilot disable<CR>", { desc = "[C]opilot o[f]f" })
	end,
}
