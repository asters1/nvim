return {
	gh .. "jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local actions = null_ls.builtins.code_actions
		local hover = null_ls.builtins.hover
		local notify = vim.notify
		vim.notify = function(msg, ...)
			if msg:match("warning: multiple different client offset_encodings") then
				return
			end

			notify(msg, ...)
		end
		local sources = {
			formatting.prettierd.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
			formatting.black.with({ extra_args = { "--fast" } }),
			formatting.stylua,
			formatting.goimports,
			formatting.gofumpt,
			formatting.rustfmt,
			formatting.shfmt,
			-- formatting.clang-format,

			diagnostics.flake8,
			diagnostics.pylint,
			-- diagnostics.golangci_lint,

			actions.gitsigns,

			hover.dictionary,
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ timeout_ms = 2000 })
						end,
					})
				end
			end,
		})
	end,
	dependencies = { gh .. "nvim-lua/plenary.nvim", gh .. "neovim/nvim-lspconfig" },
}
