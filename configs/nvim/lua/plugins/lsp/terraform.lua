--- Configure Terraform language-server support.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = { terraformls = {} },
	},
}
