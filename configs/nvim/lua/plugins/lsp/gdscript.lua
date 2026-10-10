--- Connect to Godot's GDScript language server; Godot supplies the server, not Mason.
return {
	"neovim/nvim-lspconfig",
	opts = {
		unmanaged_servers = { "gdscript" },
		servers = { gdscript = {} },
	},
}
