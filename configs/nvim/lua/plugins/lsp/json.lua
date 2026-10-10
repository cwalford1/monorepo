--- Configure JSON completion, validation, and schema support.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = { jsonls = {} },
	},
}
