--- Configure YAML completion and validation.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = { yamlls = {} },
	},
}
