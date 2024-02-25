return {
	'kyazdani42/nvim-tree.lua',
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			sort_by = "case_sensitive",
			view = {
				adaptive_size = true,
				side = 'left',
			},
				filters = {
				custom = { '.git$', 'node_modules$' }
			},
			git = {
			ignore = false,
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					}
				}
			},
			renderer = {
				icons = {
					show = {
						git = true,
						folder = true,
						file = true,
						folder_arrow = false,
					},
					glyphs = {
						default = '',
						git = {
							unstaged = '~',
							staged = '+',
							unmerged = '!',
							renamed = '≈',
							untracked = '?',
							deleted = '-',
						},
					},
				},
				indent_markers = {
					enable = true,
				},
			}
		}
		local function open_nvim_tree(data)
			-- buffer is a [No Name]
			local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

			-- buffer is a directory
			local directory = vim.fn.isdirectory(data.file) == 1

			if not no_name and not directory then
				return
			end

			-- change to the directory
			if directory then
				vim.cmd.cd(data.file)
			end

			-- open the tree
			require("nvim-tree.api").tree.open()
		end

		vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>', { silent = true })
		vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<CR>', { silent = true })

		vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
	end
}
