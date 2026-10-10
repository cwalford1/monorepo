--- Register language-specific CLI sources and format each buffer with its none-ls client on save.
return {
	"nvimtools/none-ls.nvim",
	opts_extend = { "sources" },
	opts = { sources = {} },
	config = function(_, opts)
		local null_ls = require("null-ls")
		local sources = {}
		for _, create_sources in ipairs(opts.sources) do
			vim.list_extend(sources, create_sources())
		end

		local augroup = vim.api.nvim_create_augroup("none-ls-format-on-save", { clear = true })
		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								async = false,
								bufnr = bufnr,
								filter = function(format_client)
									return format_client.id == client.id
								end,
							})
						end,
					})
				end
			end,
		})
	end,
}
