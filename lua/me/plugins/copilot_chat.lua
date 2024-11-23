return {
	"CopilotC-Nvim/CopilotChat.nvim",

	dependencies = {
		{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	},
	build = "make tiktoken", -- Only on MacOS or Linux
	opts = {
		debug = true, -- Enable debugging
		-- See Configuration section for rest
	},
	-- See Commands section for default commands if you want to lazy load on them
	config = function()
		local chat = require("CopilotChat")
		chat.setup({
			debug = true,
		})
		vim.keymap.set({ "n", "v" }, "<leader>cc", function()
			chat.toggle()
		end, { desc = "[C]opilot [C]hat" })
		-- vim.keymap.set("n", "<leader>ct", ":CopilotChatTests<CR>", { desc = "Copilot Chat Tests Suggestion" })
		-- vim.keymap.set({ "n", "v" }, "<leader>cr", ":CopilotChatReview<CR>", { desc = "Copilot Chat Review" })
		-- vim.keymap.set("n", "<leader>cs", ":CopilotChatCommit<CR>", { desc = "Copilot Chat Commit" })
		-- vim.keymap.set("n", "<leader>cS", ":CopilotChatCommitStaged<CR>", { desc = "Copilot Chat Commit Staged" })
		-- vim.keymap.set({ "n", "v" }, "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Copilot Chat Commit" })
		-- vim.keymap.set("n", "<leader>cD", ":CopilotChatDebugInfo<CR>", { desc = "Copilot Chat Debug" })
		-- vim.keymap.set({ "n", "v" }, "<leader>cF", ":CopilotChatFix<CR>", { desc = "Copilot Chat Fix" })
		-- vim.keymap.set("n", "<leader>cfd", ":CopilotChatFixDiagnostic<CR>", { desc = "Copilot Chat Fix Diagnostic" })
		-- vim.keymap.set({ "n", "v" }, "<leader>cO", ":CopilotChatOptimize<CR>", { desc = "Copilot Chat Optimize" })
		-- vim.keymap.set({ "n", "v" }, "<leader>cd", ":CopilotChatDocs<CR>", { desc = "Copilot Chat Docs" })
		-- vim.keymap.set("n", "<leader>ccs", ":CopilotChatSave ", { desc = "Copilot Chat Save to file" })
		-- vim.keymap.set("n", "<leader>ccl", ":CopilotChatLoad ", { desc = "Copilot Chat Load file" })
		vim.keymap.set("n", "<leader>cr", ":CopilotChatReset<CR>", { desc = "Copilot Chat Reset Current chat" })
		vim.keymap.set("n", "<leader>cs", ":CopilotChatStop<CR>", { desc = "Copilot Chat Stop current output" })
	end,
}
