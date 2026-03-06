vim.o.number = true
vim.o.swapfile = false
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.g.mapleader = " "
vim.o.signcolumn = "yes"

local gh = function(x) return 'https://github.com/' .. x end

-- Install Plugins
vim.pack.add({
	-- Visuals
	{
		src = gh("navarasu/onedark.nvim")
	},
	{
		src = gh("nvim-lualine/lualine.nvim")
	},
	{
		src = gh("nvim-tree/nvim-web-devicons")
	},
	-- Files
	{
		src = gh("ibhagwan/fzf-lua")
	},
	{
		src = gh("nvim-tree/nvim-tree.lua")
	},
	-- LSP
	{
		src = gh('neovim/nvim-lspconfig')
	},
	{
		src = gh("mason-org/mason.nvim")
	},
	{
		src = gh("mason-org/mason-lspconfig.nvim") -- Auto enable LSP
	},
	{
		src = gh('nvimdev/lspsaga.nvim')
	},
	{
		src = gh("MysticalDevil/inlay-hints.nvim")
	},
	{
		src = gh("onsails/lspkind.nvim")
	},
	-- Completions
	{
		src = gh('saghen/blink.cmp')
	},
	{
		src = gh('rafamadriz/friendly-snippets')
	},
	-- Git
	{
		src = gh("lewis6991/gitsigns.nvim")
	},
	-- Treesitter
	{
		src = gh('nvim-treesitter/nvim-treesitter')
	},
	-- Terminal
	{
		src = gh("akinsho/toggleterm.nvim")
	}
})

-- Initialize plugins
require('onedark').setup {
	style = "darker",
	transparent = true,
	term_colors = true
}
require('onedark').load()
require('lualine').setup()
require('fzf-lua').setup({ 'fzf-native' })
require("nvim-tree").setup()
require('lspsaga').setup()
require("inlay-hints").setup()
require("toggleterm").setup()
require("gitsigns").setup()
require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls",
		"bashls",
		"eslint",
		"basedpyright",
		"jsonls"
	}
}

require('blink.cmp').setup {
	fuzzy = {
		implementation = "lua"
	},
	completion = {
		menu = {
			draw = {
				components = {
					kind_icon = {
						text = function (ctx)
							return require("lspkind").symbol_map[ctx.kind] or ''
						end
					},
				},
			},
		},
	},
	keymap = {
		preset = 'default',

		['<C-f>'] = { (
			function(cmp) cmp.accept() end -- Set Control F to accept like zsh
		) }
	}
}

-- Keymaps
vim.keymap.set('n', '<leader>ff', FzfLua.files)
vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>')
vim.keymap.set('n', '<leader>fg', FzfLua.live_grep_native)
vim.keymap.set('n', '<leader>la', FzfLua.lsp_code_actions)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
