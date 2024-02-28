return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	dependencies = {
		-- LSP Support
		{'neovim/nvim-lspconfig'},             -- Required
		{'williamboman/mason.nvim'},           -- Optional
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},     -- Required
		{'hrsh7th/cmp-buffer'}, -- Required
		{'hrsh7th/cmp-path'}, -- Required
		{'hrsh7th/cmp-nvim-lsp'}, -- Required
		{'hrsh7th/cmp-nvim-lua'}, -- Required
		{'L3MON4D3/LuaSnip'},     -- Required

		-- Snnipets
		{'rafamadriz/friendly-snippets'},
	},
	config = function ()
		local lsp = require('lsp-zero').preset({})

		lsp.preset("recommended")

		lsp.ensure_installed({
            'tsserver',
			'eslint',
		})

        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = nil,
            ['<S-Tab>'] = nil,
        })

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

		lsp.on_attach(function(_, bufnr)
			local opts = {buffer = bufnr, remap = false}

			vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "<leader>ca", function () vim.lsp.buf.code_action() end, opts)
		end)

		lsp.setup()
	end,
}
