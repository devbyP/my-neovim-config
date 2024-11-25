local g = vim.g
local o = vim.o
local wo = vim.wo
local opt = vim.opt
local keymap = vim.keymap

g.mapleader = " "
g.maplocalleader = " "

o.termguicolors = true
opt.showmode = false

opt.breakindent = true

wo.number = true
wo.signcolumn = "yes"
wo.relativenumber = true

o.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

o.mouse = "a"

o.clipboard = "unnamedplus"

o.ignorecase = true
o.smartcase = true

o.autoindent = true
o.tabstop = 4
o.shiftwidth = 0
o.expandtab = true
o.softtabstop = -1 -- use shiftwidth, set to negative
o.wrap = false

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

o.scrolloff = 8

o.completeopt = "menuone,noselect"

o.updatetime = 250
o.timeoutlen = 500

o.splitright = true
o.splitbelow = true

opt.colorcolumn = "100"
-- wo.cursorline = true

keymap.set("i", "kj", "<ESC>", { silent = true })

-- Move line up and down in NORMAL and VISUAL modes
-- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
keymap.set("n", "<C-j>", ":move .+1<CR>", { silent = true })
keymap.set("n", "<C-k>", ":move .-2<CR>", { silent = true })
keymap.set("x", "<C-j>", ":move '>+1<CR>gv=gv", { silent = true })
keymap.set("x", "<C-k>", ":move '<-2<CR>gv=gv", { silent = true })

-- Move between window
keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
keymap.set("n", "<leader>k", "<C-w>k", { silent = true })
keymap.set("n", "<leader>l", "<C-w>l", { silent = true })

-- Resizing window
-- Resize width hold shift
keymap.set("n", "<leader>-", ":vertical resize -4<CR>", { silent = true })
keymap.set("n", "<leader>=", ":vertical resize +4<CR>", { silent = true })
-- Resize heigh no shift
keymap.set("n", "<leader>_", ":resize -4<CR>", { silent = true })
keymap.set("n", "<leader>+", ":resize +4<CR>", { silent = true })

keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	"tpope/vim-sleuth",

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"folke/neodev.nvim",
		},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					-- 	return
					-- end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},

	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to next hunk" })

				map({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "Jump to previous hunk" })

				-- Actions
				-- visual mode
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage git hunk" })
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset git hunk" })
				-- normal mode
				map("n", "<leader>gs", gs.stage_hunk, { desc = "git stage hunk" })
				map("n", "<leader>gr", gs.reset_hunk, { desc = "git reset hunk" })
				map("n", "<leader>gS", gs.stage_buffer, { desc = "git Stage buffer" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
				map("n", "<leader>gR", gs.reset_buffer, { desc = "git Reset buffer" })
				map("n", "<leader>gp", gs.preview_hunk, { desc = "preview git hunk" })
				map("n", "<leader>gb", function()
					gs.blame_line({ full = false })
				end, { desc = "git blame line" })
				map("n", "<leader>gd", gs.diffthis, { desc = "git diff against index" })
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, { desc = "git diff against last commit" })

				-- Toggles
				map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
				map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
			end,
		},
	},

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
			vim.cmd.hi("Comment gui=none")
		end,
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	"nvim-treesitter/nvim-treesitter-context",

	{ import = "me.plugins" },
}, {})

require("me.conf.telescope")
require("me.conf.treesitter")
require("me.conf.lsp")

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

require("me.gui.neovide")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=4 sts=4 sw=4 et
