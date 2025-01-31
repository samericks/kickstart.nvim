local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- Use vsnip for snippets
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
  sources = cmp.config.sources {
    { name = 'omni' }, -- Enable omnifunc completion
    { name = 'buffer' }, -- Buffer completions
    { name = 'path' }, -- File path completions
  },
}

cmp.setup.filetype('tex', {
  sources = cmp.config.sources {
    { name = 'omni' }, -- Use omnifunc (VimTeX completion)
    { name = 'buffer' },
  },
})

vim.g.vimtex_complete_enabled = 1
vim.cmd [[autocmd FileType tex setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
