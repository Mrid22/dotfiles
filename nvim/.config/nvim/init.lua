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
	-- Completions
	{
		src = gh('saghen/blink.cmp')
	},
	{
		src = gh('rafamadriz/friendly-snippets')
	},
	-- Treesitter
	{
		src = gh('nvim-treesitter/nvim-treesitter')
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
require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls",
		"bashls",
		"eslint",
		"basedpyright"
	}
}
require('blink.cmp').setup {
	fuzzy = {
		implementation = "lua"
	},
	keymap = {
		preset = 'default',

		['<C-f>'] = {(
			function(cmp) cmp.accept() end -- Set Control F to accept like zsh
		)}
	}
}

-- Keymaps
vim.keymap.set('n', '<leader>ff', FzfLua.files)
vim.keymap.set('n', '<leader>fg', FzfLua.live_grep_native)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
