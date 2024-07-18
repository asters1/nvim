return {
  gh.."lewis6991/gitsigns.nvim",
  lazy = false,
  priority = 1000,
  config = function()





    --重置
    vim.keymap.set('n', 'gr',':Gitsigns reset_hunk<CR>')
    --提示commit
    vim.keymap.set('n', 'gb',':Gitsigns blame_line<CR>')
    --跳转修改的位置
    vim.keymap.set('n', 'g-',':Gitsigns prev_hunk<CR>')
    vim.keymap.set('n', 'g=',':Gitsigns next_hunk<CR>')

    require('gitsigns').setup({
      signs = {
        add          = { hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
        change       = { hl = 'GitSignsChange', text = '░', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '▒', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
        untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
      },
    })
  end
}
