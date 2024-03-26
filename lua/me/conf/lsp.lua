-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local nmap = function(keys, func, desc)
			if desc then
				desc = "LSP: " .. desc
			end

			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		nmap("<leader>ca", function()
			vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
		end, "[C]ode [A]ction")

		nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		-- See `:help K` for why this keymap
		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
		-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

		-- Lesser used LSP functionality
		nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		nmap("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")

		nmap("<leader>fm", ":Format<CR>", "[F]or[M]at Code")

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
		-- disable lsp format on ts, js and vue
		if client and (client.name == "tsserver" or client.name == "volar") then
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
	end,
})

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
local var_vue_ts = require("me.vars.vue-ts-loc")

-- local util = require("lspconfig.util")
-- local function get_typescript_server_path(root_dir)
-- 	local global_ts = var_vue_ts.global_typescript_loc
-- 	-- Alternative location if installed as root:
-- 	-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
-- 	local found_ts = ""
-- 		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
-- 	local function check_dir(path)
-- 		if util.path.exists(found_ts) then
-- 			return path
-- 		end
-- 	end
-- 	if util.search_ancestors(root_dir, check_dir) then
-- 		return found_ts
-- 	else
-- 		return global_ts
-- 	end
-- end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
	-- clangd = {},
	gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	tsserver = {
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = var_vue_ts.vue_ts_plugin_loc,
					languages = { "javascript", "typescript", "vue" },
				},
			},
		},

		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"vue",
		},
	},
	-- html = { filetypes = { 'html', 'twig', 'hbs'} },

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
	volar = {
		-- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		-- root_dir = util.root_pattern("package.json"),
		-- init_options = {
		-- 	vue = {
		-- 		hybridMode = false,
		-- 	},
		-- 	typescript = {
		-- 		tsdk = get_typescript_server_path(vim.fn.getcwd()),
		-- 	},
		-- },
	},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"stylua", -- Used to format lua code
})

require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			require("lspconfig")[server_name].setup(server)
			-- require("lspconfig")[server_name].setup({
			-- 	cmd = server.cmd,
			-- 	settings = server.settings,
			-- 	filetypes = server.filetypes,
			-- 	-- This handles overriding only values explicitly passed
			-- 	-- by the server configuration above. Useful when disabling
			-- 	-- certain features of an LSP (for example, turning off formatting for tsserver)
			-- 	capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
			-- })
		end,
	},
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
})

require("luasnip.loaders.from_vscode").lazy_load()
