-- Options
vim.o.number = true
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.o.tabstop = 2
vim.o.softtabstop = vim.o.tabstop
vim.o.shiftwidth = vim.o.tabstop
vim.g.mapleader = " "

-- Shortcuts
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", ":FzfLua grep_visual<CR>")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>")

-- Plugins
local gh = function(x) return "https://github.com/" .. x end

vim.pack.add({
	-- Theme
	{
		src = gh("folke/tokyonight.nvim")
	},
	-- Terminal
	{
		src = gh("akinsho/toggleterm.nvim")
	},
	-- Autopairs
	{
		src = gh("nvim-treesitter/nvim-treesitter")
	},
	{
		src = gh("kylechui/nvim-surround")
	},
	{
		src = gh("windwp/nvim-autopairs")
	},
	{
		src = gh("windwp/nvim-ts-autotag")
	},
	{
		src = gh("nvim-lualine/lualine.nvim")
	},
	-- Lsp
	{
		src = gh("neovim/nvim-lspconfig")
	},
	{
		src = gh("mason-org/mason.nvim")
	},
	{
		src = gh("mason-org/mason-lspconfig.nvim") -- Automatically vim.lsp.enables stuff installed by Mason
	},
	{
		src = gh("nvimdev/lspsaga.nvim")
	},
	{
		src = gh("MysticalDevil/inlay-hints.nvim")
	},
	-- Fzf
	{
		src = gh("ibhagwan/fzf-lua")
	},
	-- Nvimtree
	{
		src = gh('nvim-tree/nvim-web-devicons')
	},
	{
		src = 'https://github.com/nvim-tree/nvim-tree.lua'
	},
	-- Git
	{
		src = gh("lewis6991/gitsigns.nvim")
	},
	-- Completions
	{
		src = gh("hrsh7th/nvim-cmp")
	},
	{
		src = gh("hrsh7th/cmp-nvim-lsp")
	},
	{
		src = gh("rafamadriz/friendly-snippets")
	},
	{
		src = gh("nvimtools/none-ls.nvim")
	},
	{
		src = gh("nvimtools/none-ls-extras.nvim")
	},
	{
		src = gh("nvim-lua/plenary.nvim")
	},
	{
		src = gh("gbprod/none-ls-shellcheck.nvim")
	}
})

require('nvim-treesitter').setup(
	{
		automatic_installation = true,
		highlight = {
			enable = true,
		},
	}
)

require('toggleterm').setup()
require("nvim-surround").setup()
require("lualine").setup()
require("nvim-tree").setup()
require('nvim-ts-autotag').setup()
require('lspsaga').setup()
require('inlay-hints').setup()


-- Autopairs
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({ -- Treesitter Integration
	check_ts = true,
	ts_config = {
		lua = { 'string' }, -- it will not add a pair on that treesitter node
		javascript = { 'template_string' },
	}
})

local ts_conds = require('nvim-autopairs.ts-conds')


-- press % => %% only while inside a comment or string
npairs.add_rules({
	Rule("%", "%", "lua")
			:with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
	Rule("$", "$", "lua")
			:with_pair(ts_conds.is_not_ts_node({ 'function' }))
})
-- Mason

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"basedpyright",
		"stylua",
		"bashls",
		"ts_ls",
	},
})

-- Null ls

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
		require("none-ls-shellcheck.diagnostics"),
		require("none-ls-shellcheck.code_actions"),
		require("none-ls.diagnostics.eslint_d"),
	},
})


-- Cmp setup

local cmp_autopairs = require('nvim-autopairs.completion.cmp') -- autopairs with completion for functions and such
local cmp = require("cmp")
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)
cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})

require('tokyonight').setup({
	style = "storm",
	transparent = "true",
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})

vim.cmd [[colorscheme tokyonight]]

-- Remove unused plugins

local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		print("No unused plugins.")
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end


vim.keymap.set("n", "<leader>pc", pack_clean)
