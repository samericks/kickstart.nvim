-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- vim.g.vimtex_view_method = 'MuPDF'
      vim.cmd 'filetype plugin indent on'
      vim.cmd 'syntax enable'
      -- vim.g.vimtex_compiler_latexmk = {
      --   build_dir = 'output', -- Specify the output directory
      --   options = {
      --     '-outdir=output', -- Pass the output directory option to latexmk
      --   },
      -- }
      -- vim.opt.conceallevel = 1
      -- vim.g.tex_conceal = 'abdmg'
      vim.opt.formatoptions:append 't'
      vim.opt.formatoptions:append 'l'
      vim.g.vimtex_fold_enabled = 0
      vim.g.vimtex_indent_enabled = 1
      vim.cmd [[
        autocmd FileType tex setlocal tabstop=4 shiftwidth=4 expandtab
      ]]
      vim.api.nvim_set_keymap('n', '<leader>w', ':normal! gqap<CR>', { noremap = true, silent = true })
    end,
  },

  { 'neomake/neomake' },

  { 'rose-pine/neovim', name = 'rose-pine' },

  { 'SirVer/ultisnips' },

  { 'honza/vim-snippets' },

  { 'tpope/vim-fugitive' },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-omni',
    },
    config = function()
      local cmp = require 'cmp'

      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources {
          { name = 'omni' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }

      cmp.setup.filetype('tex', {
        sources = cmp.config.sources {
          { name = 'omni' },
          { name = 'buffer' },
        },
      })

      vim.g.vimtex_complete_enabled = 1
      vim.cmd [[autocmd FileType tex setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
    end,
  },
}
