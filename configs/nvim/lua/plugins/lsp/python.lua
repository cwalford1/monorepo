--- Use pylsp for Python intelligence, ty for type checking, and Ruff for linting and fixes.
--- none-ls owns Python formatting, import sorting, and automatic fixes on save.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			ty = {
				settings = {
					ty = {
						disableLanguageServices = true, -- Keep completion and navigation with pylsp.
					},
				},
			},
			pylsp = {
				settings = {
					pylsp = {
						-- Avoid duplicate linting and formatting from pylsp plugins.
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							mccabe = { enabled = false },
							pylsp_mypy = { enabled = false },
							pylsp_black = { enabled = false },
							pylsp_isort = { enabled = false },
						},
					},
				},
			},
			ruff = {
				on_attach = function(client, bufnr)
					-- Keep a single formatting pipeline: none-ls runs Ruff fixes then formatting.
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					local function command(name, action, description)
						vim.api.nvim_buf_create_user_command(bufnr, name, function()
							client:exec_cmd({
								command = action,
								arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
							}, { bufnr = bufnr })
						end, { desc = description, force = true })
					end
					command("RuffAutofix", "ruff.applyAutofix", "Ruff: Fix auto-fixable problems")
					command("RuffOrganizeImports", "ruff.applyOrganizeImports", "Ruff: Organize imports")
				end,
			},
		},
	},
}
