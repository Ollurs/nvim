return {
  {
    'hrsh7th/nvim-cmp', -- Completion engine
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
      'hrsh7th/cmp-buffer',   -- Buffer source
      'hrsh7th/cmp-path',     -- Path source
      'hrsh7th/cmp-cmdline',  -- Command-line source
      'L3MON4D3/LuaSnip',     -- Snippets engine
    },
    config = function()
      local cmp = require('cmp')
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Setup LSP capabilities
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      -- Configure nvim-cmp
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end,
  },
}
