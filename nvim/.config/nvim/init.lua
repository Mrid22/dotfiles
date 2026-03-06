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
		src = gh("hrsh7th/nvim-cmp")
	},
	{
		src = gh("hrsh7th/cmp-nvim-lsp")
	},
	{
		src = gh('L3MON4D3/LuaSnip')
	},
	{
		src = gh("saadparwaiz1/cmp_luasnip")
	},
	{
		src = gh('rafamadriz/friendly-snippets')
	},
	-- Autopairs
	{
		src = gh('windwp/nvim-autopairs')
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
require("nvim-autopairs").setup {}
require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls",
		"bashls",
		"eslint",
		"basedpyright",
		"jsonls"
	}
}

  -- Set up nvim-cmp.
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require'cmp'
	require("luasnip.loaders.from_vscode").lazy_load()
	cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })


  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  vim.lsp.config('luals', {
    capabilities = capabilities
  })
  vim.lsp.config('bashls', {
    capabilities = capabilities
  })
  vim.lsp.config('eslint', {
    capabilities = capabilities
  })
  vim.lsp.config('basedpyright', {
    capabilities = capabilities
  })
  vim.lsp.config('jsonls', {
    capabilities = capabilities
  })

-- Keymaps
vim.keymap.set('n', '<leader>ff', FzfLua.files)
vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>')
vim.keymap.set('n', '<leader>fg', FzfLua.live_grep_native)
vim.keymap.set('n', '<leader>la', FzfLua.lsp_code_actions)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
