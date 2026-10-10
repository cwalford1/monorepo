--- Display a file explorer that grows to fit its longest visible entry.
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		view = {
			-- A width table enables dynamic sizing; defaults are 30 columns with one-column padding.
			width = {},
		},
	},
}
