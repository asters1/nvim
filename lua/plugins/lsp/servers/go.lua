return function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.config('gopls', {
    capabilities = capabilities,
  })
  vim.lsp.enable('gopls')
end
