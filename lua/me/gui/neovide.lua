if vim.g.neovide then
	vim.o.guifont = "FiraCode Nerd Font Mono,Cascadia Code:h13"
	vim.wo.cursorline = true
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_hide_mouse_when_typing = true
	local function toggleFullscreen()
		vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
	end
	vim.api.nvim_create_user_command("Fullscreen", toggleFullscreen, {})
	vim.keymap.set("n", "<C-CR>", toggleFullscreen, { silent = true })
end
