vim.o.swapfile = false
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.signcolumn = "yes"
vim.g.mapleader = " "

local gh = function(x)
	return "https://github.com/" .. x
end
vim.pack.add({
	gh("nvim-treesitter/nvim-treesitter"),
	gh("neovim/nvim-lspconfig"),
	gh("navarasu/onedark.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("nvim-lualine/lualine.nvim"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("ibhagwan/fzf-lua"),
	gh("saghen/blink.cmp"),
	gh("rafamadriz/friendly-snippets"),
	gh("nvim-lua/plenary.nvim"),
	gh("lewis6991/gitsigns.nvim"),
	gh("akinsho/toggleterm.nvim"),
})

require("onedark").setup({
	style = "darker",
	transparent = true,
})
require("onedark").load()
require("lualine").setup()
require("mason").setup()
require("gitsigns").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"hyprls",
		"docker_compose_language_service",
	},
})
require("fzf-lua").setup()
require("blink.cmp").setup({
	keymap = {
		preset = "enter",
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		documentation = { auto_show = false },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	fuzzy = {
		implementation = "prefer_rust",
	},
})

vim.keymap.set("n", "<leader>ff", ":FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", ":FzfLua live_grep_native<CR>")
vim.keymap.set("n", "<leader>la", ":FzfLua lsp_code_actions<CR>")
