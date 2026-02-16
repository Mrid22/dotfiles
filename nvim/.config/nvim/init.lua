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

-- Plugins
local gh = function(x) return "https://github.com/" .. x end

vim.pack.add({
	{
		src = gh("nvim-treesitter/nvim-treesitter"),
	},
	{
		src = gh("kylechui/nvim-surround"),
	},
	{
		src = gh("navarasu/onedark.nvim"),
	},
	{
		src = gh("windwp/nvim-autopairs"),
	},
	{
		src = gh("nvim-lualine/lualine.nvim"),
	},
	-- Lsp
	{
		src = gh("neovim/nvim-lspconfig"),
	},
	{
		src = gh("mason-org/mason.nvim")
	},
	{
		src = gh("mason-org/mason-lspconfig.nvim")
	},
	-- Telescope
	{
		src = gh("nvim-telescope/telescope.nvim")
	},
	{
		src = gh("nvim-lua/plenary.nvim")
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
	}
})

require("nvim-autopairs").setup()
require("nvim-surround").setup()
require("lualine").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("telescope").setup()
local cmp = require("cmp")
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
		['<CR>'] = cmp.mapping.confirm({ select = true }),   -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})

require('onedark').setup({
	style = "darker",
	transparent = "true",
})

require('onedark').load()

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
