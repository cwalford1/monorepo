--- Configure Starlark completion and diagnostics with automatically installed starpls.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			starpls = {},
		},
	},
}
