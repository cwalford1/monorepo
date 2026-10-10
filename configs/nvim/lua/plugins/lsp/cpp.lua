--- Configure clangd for C-family languages and format supported buffers on save.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			clangd = {
				on_attach = function(client, bufnr)
					local clangd_format_filetypes = {
						c = true,
						cpp = true,
						cuda = true,
						objc = true,
						objcpp = true,
					}
					if
						client.supports_method("textDocument/formatting")
						and clangd_format_filetypes[vim.bo[bufnr].filetype]
					then
						local group = vim.api.nvim_create_augroup("clangd-format-on-save", { clear = false })
						vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = group,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									async = false,
									bufnr = bufnr,
									filter = function(format_client)
										return format_client.name == "clangd"
									end,
								})
							end,
						})
					end
				end,
			},
		},
	},
}
