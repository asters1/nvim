local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    gh .. "folke/lazy.nvim",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.keymap.set("n", "<leader><leader>", ":Lazy<CR>", { noremap = true })


require("lazy").setup({
  --	主题
  require("config.plugins.colorscheme").background,
  --require("config.plugins.colorscheme").statusline1,
  require("config.plugins.colorscheme").statusline2,
  --  --注释
  require("config.plugins.comment"),
  --  --目录树
  require("config.plugins.nvim-tree"),
  --  --git提示
  require("config.plugins.gitsigns"),
  --翻译
  require("config.plugins.fy"),
  --标题栏
  require("config.plugins.tabtitle"),
  -- 语法高亮
  require("config.plugins.treesitter"),
  --缩进线
  require("config.plugins.indent"),
  --提示命令
  require("config.plugins.whichkey"),
  -- --LSP与自动补全
  -- require("config.plugins.lsp"),
  require("config.plugins.mason"),
  require("config.plugins.cmp"),
  require("config.plugins.lsp_signature"),
  require("config.plugins.autoformat"),
  -- require("config.plugins.pack-vue")
  --LSP与自动补全并且自动格式化
  -- require("config.plugins.mason"),
  -- require("config.plugins.autocomplete").config,
  -- require("config.plugins.lspconfig").config,
}, {
})
