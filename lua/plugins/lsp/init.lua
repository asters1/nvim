-- Neovim built-in LSP

return {
  gh..'neovim/nvim-lspconfig',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  lazy = false,
  dependencies = {
    gh..'mason-org/mason.nvim',
    gh..'mason-org/mason-lspconfig.nvim',
    gh..'nvimdev/lspsaga.nvim',
    {
      gh..'hasansujon786/nvim-navbuddy',
      dependencies = {
        gh..'SmiteshP/nvim-navic',
        gh..'MunifTanjim/nui.nvim',
      },
      opts = { lsp = { auto_attach = true } },
    },
  },
  build = {
    'npm i -g vscode-langservers-extracted',
    'npm i -g eslint',
    'npm i -g yaml-language-server',
  },
  config = function()
    require('plugins.lsp.mason')()
    require('plugins.lsp.lspsaga')()
    require('plugins.lsp.navbuddy')()
    require('plugins.lsp.servers')()
    require('plugins.lsp.diagnostics')()
  end,
}
