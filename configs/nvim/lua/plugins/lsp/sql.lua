--- Configure SQL language-server support.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = { sqlls = {} },
	},
}
