return {
	-- Set lualine as statusline
	'nvim-lualine/lualine.nvim',
	-- See `:help lualine.txt`
	opts = {
		options = {
			icons_enabled = false,
			theme = 'tokyonight',
			component_separators = '|',
			section_separators = '',
		},
		sections = {
			lualine_c = {
				{
					'filename',
					file_status = true,      -- Displays file status (readonly status, modified status)
					path = 1,                -- 0: Just the filename
										   -- 1: Relative path
										   -- 2: Absolute path
										   -- 3: Absolute path, with tilde as the home directory
				}
			},
		},
		inactive_sections = {
			lualine_c = {
				{
					'filename',
					file_status = true,      -- Displays file status (readonly status, modified status)
					newfile_status = false,   -- Display new file status (new file means no write after created)
					path = 1,                -- 0: Just the filename
										   -- 1: Relative path
										   -- 2: Absolute path
										   -- 3: Absolute path, with tilde as the home directory
					symbols = {
						modified = '[+]',      -- Text to show when the file is modified.
						readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
						unnamed = '[No Name]', -- Text to show for unnamed buffers.
						newfile = '[New]',     -- Text to show for new created file before first writting
					}
				}
			},
		},
	}
}
