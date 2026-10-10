--- Configure Bash language-server support.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = { bashls = {} },
	},
}
