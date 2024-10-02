return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",

		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
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
			vim.keymap.set("n", "<leader>cc", function()
				chat.toggle({
					window = {
						layout = "float",
						title = "My Ai Copilot Chat",
						width = 0.8,
						height = 0.4,
						row = 1,
					},
				})
			end, { desc = "[C]opilot [C]hat Float" })
			-- vim.keymap.set("n", "<leader>ccv", function()
			-- 	chat.open()
			-- end, { desc = "[C]opilot [C]hat Vertical" })
			-- vim.keymap.set("n", "<leader>ct", ":CopilotChatTests<CR>", { desc = "Copilot Chat Tests Suggestion" })
			-- vim.keymap.set({ "n", "v" }, "<leader>cr", ":CopilotChatReview<CR>", { desc = "Copilot Chat Review" })
			-- vim.keymap.set("n", "<leader>cs", ":CopilotChatCommit<CR>", { desc = "Copilot Chat Commit" })
			-- vim.keymap.set("n", "<leader>cS", ":CopilotChatCommitStaged<CR>", { desc = "Copilot Chat Commit Staged" })
			-- vim.keymap.set({ "n", "v" }, "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Copilot Chat Commit" })
			-- vim.keymap.set("n", "<leader>cD", ":CopilotChatDebugInfo<CR>", { desc = "Copilot Chat Debug" })
			-- vim.keymap.set({ "n", "v" }, "<leader>cf", ":CopilotChatFix<CR>", { desc = "Copilot Chat Fix" })
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>cfd",
			-- 	":CopilotChatFixDiagnostic<CR>",
			-- 	{ desc = "Copilot Chat Fix Diagnostic" }
			-- )
			-- vim.keymap.set({ "n", "v" }, "<leader>co", ":CopilotChatOptimize<CR>", { desc = "Copilot Chat Optimize" })
			-- vim.keymap.set({ "n", "v" }, "<leader>cd", ":CopilotChatDocs<CR>", { desc = "Copilot Chat Docs" })
			-- vim.keymap.set("n", "<leader>ccs", ":CopilotChatSave", { desc = "Copilot Chat Save to file" })
			-- vim.keymap.set("n", "<leader>ccl", ":CopilotChatLoad", { desc = "Copilot Chat Load file" })
			-- vim.keymap.set("n", "<leader>ccr", ":CopilotChatReset", { desc = "Copilot Chat Reset Current chat" })
		end,
	},
}
