--- Configure Dockerfile and Docker Compose language servers.
return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = { dockerls = {}, docker_compose_language_service = {} },
	},
}
