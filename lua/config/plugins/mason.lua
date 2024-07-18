-- 就这一个页面就能自动安装,不能安装的话是网络问题
return {
  gh .. "williamboman/mason-lspconfig.nvim",
  lazy = false,
  dependencies = {
    { gh .. "williamboman/mason.nvim", build = ":MasonUpdate" },
  },
  config = function()
    vim.keymap.set("n", "<leader>m", ":Mason<CR>")
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    --自动安装列表
    local m_list = {
      -- "stylua",
      -- "goimports",
      -- "gofumpt",
      -- "shfmt",
      -- -- "golangci-lint",
      -- "prettierd",
    }
    for i, value in ipairs(m_list) do
      if not (IsExists(HOME .. "/.local/share/nvim/mason/packages/" .. value)) then
        vim.cmd([[:MasonInstall ]] .. value)
      end
    end

    require("mason-lspconfig").setup({
      ensure_installed = {
        --lsp
        -- "lua_ls",    --lua
        -- "clangd",    --c,c++
        -- "quick_lint_js", --js
        -- "eslint", --js
        "gopls",     --go
        -- "bashls",    --bash
        -- "jsonls",    --json
        "pyright",   --python
        -- "jdtls",     --java
      },
      automatic_installation = true,
    })
  end,
}
